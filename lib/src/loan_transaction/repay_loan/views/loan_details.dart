import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:phincash/constants/asset_path.dart';
import 'package:phincash/constants/colors.dart';
import 'package:phincash/src/loan_transaction/loan_withdrawal/views/withdrawal.dart';
import 'package:phincash/src/loan_transaction/repay_loan/repay_loan_controller/repay_loan_controller.dart';
import 'package:phincash/widget/button_widget.dart';
import 'package:phincash/widget/custom_outlined_button.dart';
import '../../../../constants/app_string.dart';
import '../../../../utils/helpers/flushbar_helper.dart';
import '../../../../widget/formfield_widget.dart';
import '../../transactions/controller/transaction_controller.dart';


class LoanDetails extends StatefulWidget {
  final bool? isLoanOverDue;
  const LoanDetails({Key? key, this.isLoanOverDue}) : super(key: key);

  @override
  State<LoanDetails> createState() => _LoanDetailsState();
}

class _LoanDetailsState extends State<LoanDetails> {
  final repayLoanController = Get.put(RepayLoanController());
  final _controller = Get.put(TransactionController());
  final amountFormKey = GlobalKey <FormState>();
  final scaffoldKey = GlobalKey <ScaffoldState>();
  final amountController = TextEditingController();

  void showAmountBottomSheet(){
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
                        Form(key: amountFormKey,
                          child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(alignment: Alignment.centerLeft,
                                  child: Image.asset(AssetPath.pngSplash, height: 100, width: 100,) //SvgPicture.asset(AssetPath.logoStamp, theme: const SvgTheme(fontSize: 25),),
                              ),
                              Text("Please enter amount proceed", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, fontSize: 14 ),),
                              const SizedBox(height: 30,),
                              FormFieldWidget(
                                onChanged: (value){
                                  _controller.amount = amountController.text;
                                },
                                controller: amountController,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.fromLTRB(16.0,8.0,8.0,8.0),
                                  child: Text("₦ ", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w400),),
                                ),
                                inputFormatters: [
                                  ThousandsFormatter(),
                                ],
                                keyboardType: TextInputType.number,
                                labelText: "Enter an amount",
                                labelStyle:TextStyle(color: Colors.black45, fontSize: 15, fontFamily: AppString.latoFontStyle),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height / 20,),
                              ButtonWidget(
                                  onPressed: (){
                                    _controller.amount == null || _controller.amount!.length < 2 ? FlushBarHelper(Get.context!).showFlushBar("Please Enter a Valid Amount") :
                                    _controller.creditWalletNow();
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


  @override
  Widget build(BuildContext context) {
    final format = new NumberFormat("#,##0", "en_US");
    String convertedDate = Jiffy(_controller.loanDetails?.data?.createdAt).yMMMMEEEEd;
    return GetBuilder<RepayLoanController>(
      init: RepayLoanController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
              title: Text("Loan Details", style:
              Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
              leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black,)),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(24.0,24.0,24.0,0.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: MediaQuery.of(context).size.height / 12, width: double.maxFinite,
                    decoration: BoxDecoration( borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(height: 50, width: 50, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.5)),
                                    child: _controller.userPersonalData?.user.gender == "male" ?
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(AssetPath.male),
                                    ) : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(AssetPath.female),
                                    ),
                                  ),
                                  Column(crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Text(_controller.userPersonalData!.user.email,
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle,color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 14),),
                                          const SizedBox(width: 10,),
                                          Icon(Icons.email, color: kPrimaryColor,)
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text(_controller.userPersonalData!.user.phoneNumber,
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 14),),
                                          const SizedBox(width: 10,),
                                          Icon(Icons.phone, color: kPrimaryColor,)
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(width: 10,),
                              Text("${_controller.userPersonalData!.user.firstName} ${_controller.userPersonalData!.user.lastName}",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12, fontFamily: AppString.latoFontStyle, color: kPrimaryColor),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(height: MediaQuery.of(context).size.height / 10, width: double.maxFinite,
                    decoration: BoxDecoration(color: const Color(0xffA6A6AA).withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red,),
                        Text("Failure to make repayment will lead to additional increase \nin interest rate and will in turn lead to penalty fee \nof 2.5% of the actual loan amount",
                        textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, fontSize: 10),)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Container(height: MediaQuery.of(context).size.height / 5.3, width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Loan Status", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600, fontSize: 14),),
                          const SizedBox(height: 10,),
                          _controller.userPersonalData?.user.hasLoanOverdue == true  && _controller.userPersonalData?.user.hasUnpaidLoan == true ?
                          Text("OverDue", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45,fontFamily: AppString.latoFontStyle),)
                              : _controller.userPersonalData?.user.hasLoanOverdue == false  && _controller.userPersonalData?.user.hasUnpaidLoan == true && _controller.userPersonalData?.user.mainWalletAmount != null ?
                          Text("Disbursed To Wallet", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45,fontFamily: AppString.latoFontStyle, fontSize: 12),) : const SizedBox(),
                          const Divider(),
                          const SizedBox(height: 10,),
                          Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Disbursement Date",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black,
                                        fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600, fontSize: 14),),
                                  const SizedBox(height: 10,),
                                  Text(convertedDate, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45,fontFamily: AppString.latoFontStyle, fontSize: 12),),
                                ],
                              ),
                              const SizedBox(width: 30,),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Wallet Amount",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle,
                                        fontWeight: FontWeight.w600, fontSize: 12),),
                                  const SizedBox(height: 10,),
                                  Text("N ${format.format(int.parse(_controller.userPersonalData!.user.mainWalletAmount.toString()))}",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black,
                                        fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600, fontSize: 12),),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Container(height: MediaQuery.of(context).size.height / 5, width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Loan amount", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45,fontFamily: AppString.latoFontStyle, fontSize: 14),),
                          const SizedBox(height: 10,),
                          Text("N ${format.format(int.parse(_controller.loanDetails!.data!.amount.toString()))}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600, fontSize: 12),),
                          const SizedBox(height: 10,),
                          const Divider(),
                          const SizedBox(height: 10,),
                          Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Interest rate",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600, fontSize: 14),),
                                  const SizedBox(height: 10,),
                                  Text("${_controller.loanDetails!.data!.loanPackage?.interestRate} %",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600, fontSize: 12),),
                                ],
                              ),
                              const SizedBox(width: 20,),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Loan duration",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600, fontSize: 14),),
                                  const SizedBox(height: 10,),
                                  Text("${_controller.loanDetails!.data!.loanPackage?.duration} Days",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600, fontSize: 12),),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ButtonWidget(
                    onPressed: (){
                      showAmountBottomSheet();
                    }, buttonText: widget.isLoanOverDue == true ? "Repay Loan" : "Fund Wallet" ,
                      height: 48,
                      width: double.maxFinite,
                  ),
                  const SizedBox(height: 10,),
                  widget.isLoanOverDue == true ? const SizedBox() : CustomOutlineButton(
                      height: 55, text: "Withdraw From Wallet",
                      onPressed: (){
                        Get.to(()=> const Withdrawal());
                      }
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
