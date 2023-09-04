import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/constants/colors.dart';
import 'package:phincash/src/loan_transaction/repay_loan/repay_loan_controller/repay_loan_controller.dart';
import 'package:phincash/src/loan_transaction/repay_loan/views/confirm_repayment.dart';
import 'package:phincash/widget/button_widget.dart';
import 'package:phincash/widget/formfield_widget.dart';

import '../../../../constants/app_string.dart';
class SelectPaymentAmount extends StatelessWidget {
  const SelectPaymentAmount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RepayLoanController>(
      init: RepayLoanController(),
        builder: (controller){
          return SafeArea(top: false, bottom: false,
              child: Scaffold(
                appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
                  title: Text(AppString.confirmAmount,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 25, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
                  leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black,)),
                ),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0,24.0,24.0,0.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50,),
                      Text(AppString.howMuch, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18, fontFamily: AppString.latoFontStyle),),
                      const SizedBox(height: 80,),
                      Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: SizedBox(
                          height: 60, width: double.maxFinite,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text("Next amount due", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54, fontFamily: AppString.latoFontStyle, fontSize: 18),),
                              ),
                              Row(
                                children: [
                                  Text("N20,200", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54, fontFamily: AppString.latoFontStyle, fontSize: 18, fontWeight: FontWeight.w700),),
                                  Radio(value: "Male", groupValue: "Amount",
                                    onChanged: (value){

                                    },
                                    activeColor: kPrimaryColorLight,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: SizedBox(
                          height: 60, width: double.maxFinite,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text("Next amount due", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54, fontFamily: AppString.latoFontStyle, fontSize: 18),),
                              ),
                              Row(
                                children: [
                                  Text("N20,200", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54, fontFamily: AppString.latoFontStyle, fontSize: 18, fontWeight: FontWeight.w700),),
                                  Radio(value: "Male", groupValue: "Amount",
                                    onChanged: (value){

                                    },
                                    activeColor: kPrimaryColorLight,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50,),
                      Align(alignment: Alignment.center,
                        child: Text("OR", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: AppString.latoFontStyle),),
                      ),
                      const SizedBox(height: 50,),
                      FormFieldWidget(
                        labelText: "Enter other amount",
                      ),
                      const Spacer(flex: 3,),
                      ButtonWidget(
                          onPressed: (){
                            Get.to(()=> const ConfirmRepayment());
                          },
                          buttonText: AppString.continueBtnTxt,
                          height: 60, width: double.maxFinite
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              )
          );
        }
    );
  }
}
