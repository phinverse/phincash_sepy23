import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/colors.dart';
import '../../../../widget/button_widget.dart';


class LoanApprovalPendingDialog{
  BuildContext? context;
  LoanApprovalPendingDialog({this.context});
  showApprovalDialog(BuildContext context){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox(height: MediaQuery.of(context).size.height / 2, width: MediaQuery.of(context).size.width / 1.3,
                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(height: 73, width: 73,
                                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kPrimaryColor, width: 3), color: const Color(0xff081952)),
                                    child: Center(child:  Icon(Icons.pending, color: kPrimaryColorLight, size: 40,))
                                ),
                              ),
                              Container(height: 40, width: 3, color: kPrimaryColor,),
                              const SizedBox(height: 20,),
                              Text("Transaction pending!", textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.w700, fontSize: 20),),
                              const SizedBox(height: 20,),
                              Text("Your Loan request is a work in progress. Please wait for approval from the Admin. Please be patient, We'll get back to you", textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.w400, fontSize: 16),),
                              const SizedBox(height: 18,),
                              ButtonWidget(
                                onPressed: (){
                                  Get.back();
                                }, buttonText: "Accept",
                                height: 50, width: double.maxFinite,
                                buttonColor: kPrimaryColor,
                              ),
                              const Spacer(flex: 2,),
                            ],
                          ),
                        )),
                  ],
                )
            ),
          );}
    );
  }
}