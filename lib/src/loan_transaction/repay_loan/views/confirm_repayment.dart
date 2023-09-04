import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:phincash/widget/button_widget.dart';
import '../../../../constants/app_string.dart';
import '../../transactions/transaction_views/home_screen.dart';


class ConfirmRepayment extends StatelessWidget {
  const ConfirmRepayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    customSuccessDialog(){
      showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: SizedBox(height: MediaQuery.of(context).size.height / 1.9,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 3,),
                          Lottie.asset('assets/lottie/checked.json', height: 300, width: 400, alignment: Alignment.center),
                          const SizedBox(height: 30,),
                          ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.4, minHeight: 50),
                              child: Text("Your loan of N20,000 has been paid. You are invited to re apply for a new loan.", textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18,fontFamily: AppString.latoFontStyle, color: Colors.black54),)),
                          const Spacer(flex: 2,),
                          ButtonWidget(
                              onPressed: (){
                                Get.offAll(()=> const HomeScreen());
                              }, buttonText: "Go back home",
                              height: 55, width: double.maxFinite
                          ),
                          const Spacer(flex: 8,),
                        ],
                      ),
                    ),
                  )
              ),
            );}
      );
    }
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
            title: Text("confirm repayment",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 25, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
            leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black,)),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50,),
                ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.6, minHeight: 50),
                    child: Text("Your account will be automatically debited on the next due date. Continue to pay early without penalty.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20,fontFamily: AppString.latoFontStyle, color: Colors.black54, fontWeight: FontWeight.w400),)),
                const SizedBox(height: 50,),
                Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Container(height: MediaQuery.of(context).size.height / 5, width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(30),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Loan amount", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45,fontFamily: AppString.latoFontStyle),),
                        const SizedBox(height: 20,),
                        Text("20,200", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600, fontSize: 25),),
                        const SizedBox(height: 10,),
                        const Divider(),
                        const SizedBox(height: 10,),
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("From Account", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
                                const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SizedBox(height: 40, width: 60, child: Image.asset("assets/png_assets/master.png")),
                                    const SizedBox(width: 20,),
                                    const Text("**** **** 3422 9900", style: TextStyle(color: Colors.black, fontSize: 17),),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(width: 30,),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Remaining balance", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
                                const SizedBox(height: 10,),
                                Text("N 0.00", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 3,),
                ButtonWidget(onPressed: (){
                  customSuccessDialog();
                }, buttonText: "Confirm", height: 60, width: double.maxFinite),
                const Spacer(),
              ],
            ),
          ),
        )
    );
  }
}
