import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phincash/src/loan_transaction/loan_withdrawal/loan_withdrawal_controller/withdrawal_controller.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/card_validation_util/input_formatters.dart';
import '../../../../utils/card_validation_util/my_strings.dart';
import '../../../../utils/card_validation_util/payment_card.dart';
import '../../../../widget/button_widget.dart';
import '../../../../widget/formfield_widget.dart';

class AddCardScreen extends StatefulWidget {
  final bool? payLoanBackManuallyProcess;
  const AddCardScreen({Key? key, this.payLoanBackManuallyProcess})
      : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _withdrawalController = Get.put(WithdrawalController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  var numberController = TextEditingController();
  final _paymentCard = PaymentCard();
  var _autoValidateMode = AutovalidateMode.disabled;

  final _card = PaymentCard();

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      _paymentCard.type = cardType;
    });
  }

  void _validateInputs() {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode =
            AutovalidateMode.always; // Start validating on every change.
      });
      _showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      // Encrypt and send send payment details to payment gateway
      _showInSnackBar('Payment card is valid');
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
        child: GetBuilder<WithdrawalController>(
            init: WithdrawalController(),
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
                          fontSize: 25,
                          fontFamily: AppString.latoFontStyle,
                          fontWeight: FontWeight.w700),
                    ),
                    leading: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        )),
                  ),
                  key: _scaffoldKey,
                  body: Column(
                    children: [
                      Form(
                        key: _formKey,
                        autovalidateMode: _autoValidateMode,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width /
                                              1.8,
                                      minHeight: 50),
                                  child: Text(
                                    "Kindly provide one of your card details.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: 20,
                                            fontFamily: AppString.latoFontStyle,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              FormFieldWidget(
                                controller:
                                    _withdrawalController.cardNameController,
                                padding: EdgeInsets.only(left: 15),
                                onSaved: (String? value) {
                                  _card.name = value;
                                },
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.black45,
                                  size: 20,
                                ),
                                keyboardType: TextInputType.text,
                                validator: (String? value) =>
                                    value!.isEmpty ? Strings.fieldReq : null,
                                labelText: "Card Name",
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 15,
                                        fontFamily: AppString.latoFontStyle,
                                        color: Colors.black45),
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
                                  CardNumberInputFormatter()
                                ],
                                onSaved: (String? value) {
                                  print('onSaved = $value');
                                  print(
                                      'Num controller has = ${numberController.text}');
                                  _paymentCard.number =
                                      CardUtils.getCleanedNumber(value!);
                                },
                                validator: CardUtils.validateCardNum,
                                controller: numberController,
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 15,
                                        fontFamily: AppString.latoFontStyle,
                                        color: Colors.black45),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: FormFieldWidget(
                                      padding: EdgeInsets.only(left: 15),
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
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
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: 15,
                                              fontFamily:
                                                  AppString.latoFontStyle,
                                              color: Colors.black45),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: FormFieldWidget(
                                      padding: EdgeInsets.only(left: 20),
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(4),
                                        CardMonthInputFormatter()
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
                                        List<int> expiryDate =
                                            CardUtils.getExpiryDate(value!);
                                        _paymentCard.month = expiryDate[0];
                                        _paymentCard.year = expiryDate[1];
                                      },
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: 15,
                                              fontFamily:
                                                  AppString.latoFontStyle,
                                              color: Colors.black45),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Colors.black45,
                                            fontFamily:
                                                AppString.latoFontStyle),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ButtonWidget(
                                  onPressed: () {
                                    widget.payLoanBackManuallyProcess == true
                                        ? Get.back()
                                        : null;
                                  },
                                  //_validateInputs,
                                  buttonText: "Save",
                                  height: 55,
                                  width: double.maxFinite),
                            ],
                          ),
                        ),
                      )
                    ],
                  ));
            }));
  }
}
