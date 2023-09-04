import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:phincash/src/loan_transaction/loan_withdrawal/loan_withdrawal_controller/withdrawal_controller.dart';
import 'package:phincash/src/loan_transaction/loan_withdrawal/views/add_bank_account.dart';
import 'package:phincash/src/loan_transaction/loan_withdrawal/views/confirm_withdrawal.dart';
import 'package:phincash/widget/formfield_widget.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/asset_path.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/helpers/flushbar_helper.dart';
import '../../../../widget/bottom_sheet.dart';
import '../../../../widget/button_widget.dart';


class Withdrawal extends StatelessWidget {
  const Withdrawal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _withdrawalController = Get.put(WithdrawalController());

    Widget _accountSelected(){
      final format = new NumberFormat("#,##0", "en_US");
      return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
          ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5, minHeight: 30),
              child: Text("Enter an amount you want to withdraw",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black87, fontWeight: FontWeight.w400),)),
          Text("Available Balance: ₦ ${format.format(int.parse(_withdrawalController.transactionController.userPersonalData!.user.mainWalletAmount.toString()))}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),),
          const SizedBox(height: 30,),
          FormFieldWidget(
            onChanged: (value){
              _withdrawalController.loanAmount = _withdrawalController.loanAmountController.text;
            },
            controller: _withdrawalController.loanAmountController,
            prefixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(16.0,8.0,8.0,8.0),
              child: Text("₦ ", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w400),),
            ),
            inputFormatters: [
              ThousandsFormatter(),
            ],
            keyboardType: TextInputType.number,
            labelText: "Enter an amount",
            labelStyle:TextStyle(color: Colors.black45, fontSize: 14, fontFamily: AppString.latoFontStyle),
          ),
          const SizedBox(height: 25,),
          // _commentForm(),
          const Spacer(flex: 1,),
          ButtonWidget(
              onPressed: (){
                _withdrawalController.loanAmount == null || _withdrawalController.loanAmount!.length < 2 ? FlushBarHelper(Get.context!).showFlushBar("Please Enter a Valid Amount") :
                Get.to(()=> const ConfirmWithdrawal());
              },
              buttonText: AppString.continueBtnTxt,
              height: 48, width: double.maxFinite
          ),
          const Spacer(),

        ],
      );
    }

    void showAccountBottomSheet(BuildContext context){
      MyBottomSheet().showDismissibleBottomSheet(context: context, height: MediaQuery.of(context).size.height / 2,
          child:   Column(
            children: [
              const SizedBox(height: 10,),
              Container(height: 5, width: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),),
              const SizedBox(height: 30,),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<WithdrawalController>(
                            init: WithdrawalController(),
                            builder: (controller){
                              return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Select Account", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),),
                                  const SizedBox(height: 60,),
                                  _withdrawalController.transactionController.bankAccounts!.isEmpty || _withdrawalController.transactionController.bankAccounts == null ?
                                  SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(AssetPath.noRecords),
                                          const Text("No Account Available", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: AppString.latoFontStyle),),
                                          const SizedBox(height: 10,),
                                          const Text("They will appear once there’s any", style: TextStyle(color: Color(0xFFA6A6AA), fontSize: 12, fontWeight: FontWeight.w200, fontFamily: AppString.latoFontStyle),),
                                        ],
                                      )
                                  ) :
                                  SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ...List.generate(_withdrawalController.transactionController.bankAccounts!.length, (index){
                                          return InkWell(
                                            onTap: (){
                                              _withdrawalController.selectAccount(index);
                                            },
                                            child: Padding(padding: const EdgeInsets.only(bottom: 7,top: 7),
                                              child: Row(
                                                children: [
                                                  Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade500),
                                                      child: Lottie.asset('assets/lottie/credit_cards.json',height:30, width: 30, alignment: Alignment.center)),
                                                  const SizedBox(width: 20,),
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(_withdrawalController.transactionController.bankAccounts![index].bankName!, style: const TextStyle(color: kPrimaryColor, fontSize: 12, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
                                                      Text(_withdrawalController.transactionController.bankAccounts![index].accountNumber!, style: const TextStyle(fontSize: 12, fontFamily: AppString.latoFontStyle),),
                                                      const SizedBox(height: 5,),
                                                      Text(_withdrawalController.transactionController.bankAccounts![index].accountName!, style: const TextStyle(fontSize: 10, fontFamily: AppString.latoFontStyle),),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  _withdrawalController.selectedBankAccount == _withdrawalController.transactionController.bankAccounts![index].accountNumber ? Container(height: 18, width: 18,
                                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                                                    child: const Icon(Icons.check, size: 12, color: Colors.white,),
                                                  ): const SizedBox()
                                                ],
                                              ),
                                            ),);
                                        },),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                            )
                      ]
                  ),
                ),
              ),
              InkWell(onTap: (){
                Get.to(()=> const AddBankAccount());
              },
                child: Container(height: 48,width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: kPrimaryColor)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Expanded(child: Center(child: Text("Add new", maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, color: kPrimaryColor, fontWeight: FontWeight.w700),))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30,),
            ],
          ),
      );
    }
    return GetBuilder<WithdrawalController>(
      init: WithdrawalController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(resizeToAvoidBottomInset: false,
            appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
              title: Text("Withdrawal",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
              leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,)),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(24.0,24.0,24.0,0.0),
              child:  _withdrawalController.isBankAccountSelected == true ? _accountSelected() :
              Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50,),
                  ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2, minHeight: 50),
                      child: Text("Select an account you want your borrowed loan to go to",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black87, fontWeight: FontWeight.w400),)),
                  const SizedBox(height: 40,),
                  Container(height: 67, width: double.maxFinite,padding: EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 0.7), borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Icon(Icons.account_balance, color: Colors.black45, size: 20,),
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                            onPressed: (){
                              showAccountBottomSheet(context);
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_withdrawalController.selectedBankAccount ??  "Selected Account", style: TextStyle(color: _withdrawalController.selectedBankAccount == null ||
                                      _withdrawalController.selectedBankAccount == "Selected Account"? Colors.black45 : Colors.black, fontSize: 14, fontFamily: AppString.latoFontStyle),),
                                const Icon(Icons.keyboard_arrow_down, color: Colors.black45),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 4,),
                  ButtonWidget(
                      onPressed: (){
                        if(_withdrawalController.selectedBankAccount != null && _withdrawalController.selectedBankAccount != "Select Account"){
                          _withdrawalController.bankSelected();
                        }else{
                          FlushBarHelper(Get.context!).showFlushBar("Please Select Account to Proceed");
                        }
                      },
                      buttonText: AppString.continueBtnTxt,
                      height: 48, width: double.maxFinite
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )
      );
    });
  }
}
