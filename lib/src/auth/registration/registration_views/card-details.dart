import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phincash/src/auth/registration/controller/registration_controller.dart';
import 'package:phincash/widget/formfield_widget.dart';
import 'package:phincash/constants/app_string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phincash/constants/colors.dart';
import 'package:phincash/widget/button_widget.dart';
import 'package:phincash/utils/card_validation_util/input_formatters.dart';
import 'package:phincash/utils/card_validation_util/my_strings.dart';
import 'package:phincash/utils/card_validation_util/payment_card.dart';
import 'package:dio/dio.dart';
import 'package:phincash/services/dio_services/dio_services.dart';// Import your DioServices class
import 'package:phincash/utils/helpers/progress_dialog_helper.dart';  // Import your progress dialog class
import 'package:phincash/services/dio_service_config/dio_error.dart';
import 'package:phincash/utils/helpers/flushbar_helper.dart';
import '../registration_views/webview.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _controller = Get.put(RegistrationController());
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final _formKey = GlobalKey<FormState>();
  final numberController = TextEditingController();

  Future<void> updateOnBoardingStage({required String onBoardStage}) async {
    try {
      await DioServices().onBoardingStage(onBoardStage: onBoardStage);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!)
          .showFlushBar(err.response?.data["message"] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar(err.toString());
      throw err.toString();
    }
  }

  PaymentCard _paymentCard = PaymentCard();

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFromNumber);
  }

  @override
  void dispose() {
    numberController.removeListener(_getCardTypeFromNumber);
    numberController.dispose();
    super.dispose();
  }

  void _getCardTypeFromNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      _paymentCard.type = cardType;
    });
  }

  Future<String> checkTransactionStatus(transaction_id) async {
    try {
      final transactionStatus = await DioServices().checkTransactionStatus(transaction_id);

      // Check the transaction status and return 'success' or 'fail' accordingly
      if (transactionStatus == 'success') {
        return 'success';
      } else {
        return 'fail';
      }
    } catch (err) {
      // Handle errors, e.g., show an error message
      print('Error checking transaction status: $err');
      // Return 'fail' in case of an error
      return 'fail';
    }
  }

  void _validateInputs() {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
      _showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      DioServices()
          .saveCardDetails(
        /* No longer saving the card but generating payment link
        cardNumber: _paymentCard.number.toString(),
        cvv: _paymentCard.cvv.toString(),
        expiryMonth: _paymentCard.month.toString(),
        expiryYear: _paymentCard.year.toString(),*/
      )
          .then((response) async {
        final paymentUrl = response.data['link'];
        final trxId = response.data['trx_id'];

        debugPrint("==============================");
        debugPrint("details $paymentUrl $trxId");

        // Navigate to the WebView page to complete the transaction
        Get.to(() => WebViewPage(url: paymentUrl))?.then((_) {
          // Check the transaction status in the background

        })
            .catchError((error) {
          ProgressDialogHelper().hideProgressDialog(Get.context!);
          _showInSnackBar('Error: $error');
        });
      });
    }
  }


  void _showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<RegistrationController>(
        init: RegistrationController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                "Add Card",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: AppString.latoFontStyle,
                  fontWeight: FontWeight.w700,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            body: Form(
              key: _formKey,
              autovalidateMode: _autoValidateMode,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 1.8,
                        minHeight: 50,
                      ),
                      child: Text(
                        "Kindly provide one of your card details.",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 20,
                          fontFamily: AppString.latoFontStyle,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                FormFieldWidget(
                  keyboardType: TextInputType.name,
                  labelText: "Full Name",
                  controller: _controller.bankAccountName,
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontFamily: AppString.latoFontStyle,
                    color: Colors.black45,
                  ),
                      icon: const Icon(
                        Icons.person,
                        color: Colors.black45,
                        size: 20,
                      ),
                      validator: (String? value) =>
                      value!.isEmpty ? Strings.fieldReq : null,

                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormFieldWidget(
                      padding: EdgeInsets.only(left: 15),
                      labelText: "Card Number",
                      keyboardType: TextInputType.number,
                      icon: CardUtils.getCardIcon(_paymentCard.type),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19),
                        CardNumberInputFormatter(),
                      ],
                      onSaved: (String? value) {
                        print('onSaved = $value');
                        print('Num controller has = ${numberController.text}');
                        _paymentCard.number = CardUtils.getCleanedNumber(value!);
                      },
                      validator: CardUtils.validateCardNum,
                      controller: numberController,
                      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontFamily: AppString.latoFontStyle,
                        color: Colors.black45,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FormFieldWidget(
                            padding: EdgeInsets.only(left: 15),
                            width: MediaQuery.of(context).size.width / 2.4,
                            labelText: "CVV",
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            icon: const Icon(
                              Icons.credit_card,
                              size: 20,
                              color: Colors.black45,
                            ),
                            validator: CardUtils.validateCVV,
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              _paymentCard.cvv = int.parse(value!);
                            },
                            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 15,
                              fontFamily: AppString.latoFontStyle,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: FormFieldWidget(
                            padding: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width / 2.4,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              CardMonthInputFormatter(),
                            ],
                            icon: const Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.black45,
                              size: 20,
                            ),
                            labelText: 'Expiry Date',
                            validator: CardUtils.validateDate,
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              List<int> expiryDate = CardUtils.getExpiryDate(value!);
                              _paymentCard.month = expiryDate[0];
                              _paymentCard.year = expiryDate[1];
                            },
                            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 15,
                              fontFamily: AppString.latoFontStyle,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.lock_outlined,
                          color: kPrimaryColorLight,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Your payment info will be stored securely",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.black45,
                            fontFamily: AppString.latoFontStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                      onPressed: _validateInputs,
                      buttonText: AppString.continueBtnTxt,
                      height: 48,
                      width: double.maxFinite,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
