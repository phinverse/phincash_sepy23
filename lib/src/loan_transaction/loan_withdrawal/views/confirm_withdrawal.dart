import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:phincash/src/loan_transaction/transactions/transaction_views/home_screen.dart';
import 'package:phincash/widget/button_widget.dart';
import 'package:phincash/widget/pin_code_widget.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/asset_path.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/helpers/flushbar_helper.dart';
import '../../../../widget/custom_dialog.dart';
import '../../transactions/controller/transaction_controller.dart';
import '../loan_withdrawal_controller/withdrawal_controller.dart';
class ConfirmWithdrawal extends StatelessWidget {
  const ConfirmWithdrawal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _withdrawalController = Get.put(WithdrawalController());
    final format = new NumberFormat("#,##0", "en_US");
    final remainingBalance = _withdrawalController.transactionController.loanAmount! - int.parse("${_withdrawalController.loanAmount}".replaceAll(",", ""));

    void showMyDialog() {
      MyDialog().showMyDialog(context, MediaQuery.of(context).size.height / 2,
          MediaQuery.of(context).size.width / 1.3, [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(alignment: Alignment.centerRight,
                        child: IconButton(onPressed: (){
                          Get.back();
                        }, icon: Icon(Icons.clear, color: kPrimaryColor, size: 20,)),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(height: 73, width: 73,
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kPrimaryColor, width: 3), color: const Color(0xff081952)),
                          child: Center(child:  Icon(Icons.warning_rounded, color: kPrimaryColorLight, size: 40,))
                        ),
                      ),
                      Container(height: 40, width: 3, color: kPrimaryColor,),
                      const SizedBox(height: 20,),
                      Text("Sorry! You request cannot be granted", textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.w700, fontSize: 18),),
                      const SizedBox(height: 20,),
                      Text("Your Kyc is not verified. Please click the below button to verify your kyc", textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.w400, fontSize: 16),),
                      const SizedBox(height: 18,),
                      ButtonWidget(
                        onPressed: (){
                          Get.back();
                          _withdrawalController.verifyUser();
                        }, buttonText: "Verify KYC",
                          height: 50, width: double.maxFinite,
                        buttonColor: kPrimaryColor,
                      ),
                      const Spacer(flex: 2,),
                    ],
                  ),
                ))
          ]);
    }
    final _transactionController = Get.put(TransactionController());

    Future<void> checkConnectionWithdrawal() async {
      if(_withdrawalController.formKeyPin.currentState!.validate()){
        _withdrawalController.formKeyPin.currentState!.save();
        var connectivityResult = await Connectivity().checkConnectivity();
        if (!(connectivityResult == ConnectivityResult.none)) {
          if(_transactionController.userPersonalData?.user.kycVerificationStatus == "unverified"){
            showMyDialog();
            FlushBarHelper(Get.context!).showFlushBar("Please, verify your Kyc is Unverified");
          }else{
            _withdrawalController.confirmWithdrawal();
          }
        }else {
          FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
        }
      }
    }




    void showPinBottomSheet(){
      Get.bottomSheet(
          FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/1.8,),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Container(height: 5, width: 50,
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5),),),
                  const SizedBox(height: 30,),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Form(
                              key: _withdrawalController.formKeyPin,
                              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(alignment: Alignment.centerLeft,
                                      child: Image.asset(AssetPath.pngSplash, height: 100, width: 100,) //SvgPicture.asset(AssetPath.logoStamp, theme: const SvgTheme(fontSize: 25),),
                                  ),
                                  Text("Please insert your transaction pin and proceed",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, fontSize: 14 ),),
                                  const SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                                    child: PinCodeWidget(
                                      onChanged: (value){
                                        _withdrawalController.pin = _withdrawalController.pinController.text;
                                      },
                                      length: 4,
                                      controller: _withdrawalController.pinController,
                                      validator: (v) {
                                        if(v!.isEmpty){
                                          return "Please enter 4-digit transaction pin";
                                        } else if (v.length < 4) {
                                          return "Pin must be 4 digits";
                                        } else {
                                          return null;
                                        }},
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height / 20,),
                                  ButtonWidget(
                                      onPressed: (){
                                        checkConnectionWithdrawal();
                                      },
                                      buttonText: AppString.continueBtnTxt, height: 48, width: double.maxFinite
                                  ),
                                ],
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
        ),
        isScrollControlled: true,
      );
    }

    return SafeArea(top: false, bottom: false,
        child: Scaffold(resizeToAvoidBottomInset: false,
          key: _withdrawalController.scaffoldKeyPin,
          appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
            title: Text("Withdrawal",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
            leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,)),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(24.0,24.0,24.0,0.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                      children: [
                        ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5, minHeight: 50),
                            child: Text("Please confirm your details below",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black54, fontWeight: FontWeight.w400),)),
                        const SizedBox(height: 60,),
                        Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Container(height: MediaQuery.of(context).size.height / 4.5, width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(20),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Loan amount", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45,fontFamily: AppString.latoFontStyle),),
                                const SizedBox(height: 10,),
                                Text("₦ ${format.format(int.parse(_withdrawalController.transactionController.userPersonalData!.user.mainWalletAmount.toString()))}",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600, fontSize: 14),),
                                const SizedBox(height: 10,),
                                const Divider(),
                                const SizedBox(height: 10,),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("From Account", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
                                        const SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Container(height: 30, width: 30, decoration: BoxDecoration(color: Colors.grey.shade500, shape: BoxShape.circle),
                                              child: Lottie.asset("assets/lottie/credit_cards.json",height: 30, width: 30),),
                                            const SizedBox(width: 10,),
                                            Column(
                                              children: [
                                                Text("${_withdrawalController.bankName}", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: AppString.latoFontStyle),),
                                                const SizedBox(height: 5,),
                                                Text("${_withdrawalController.accountNumber}", style: TextStyle(color: Colors.black, fontSize: 12),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Remaining balance", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
                                        const SizedBox(height: 10,),
                                        Text("₦ ${format.format(int.parse(remainingBalance.toString()))}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 100,),
                        ButtonWidget(
                            onPressed: (){
                              _withdrawalController.pin == null ? showPinBottomSheet() : null;
                            },
                            buttonText: "Confirm withdrawal",
                            height: 48, width: double.infinity
                        ),
                        const SizedBox(height: 30,),
                        InkWell(onTap: (){
                          Get.offAll(()=>const HomeScreen());

                        },
                          child: Container(height: 48,width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: kPrimaryColor)),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Expanded(child: Center(child: Text("Go Home", maxLines: 1, textAlign: TextAlign.center,
                                overflow: TextOverflow.fade, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, color: kPrimaryColor, fontWeight: FontWeight.w700),))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}
