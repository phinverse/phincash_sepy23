import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../constants/app_string.dart';
import 'button_widget.dart';

class SuccessDialog{
  BuildContext? context;
  SuccessDialog({this.context});
  showSuccessDialog(BuildContext context){
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
                            child: Text("Your withdrawal was successful", textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18,fontFamily: AppString.latoFontStyle, color: Colors.black54),)),
                        const Spacer(flex: 1,),
                        ButtonWidget(
                            onPressed: (){
                              Get.back();
                            }, buttonText: "Ok",
                            height: 55, width: double.maxFinite
                        ),
                        const Spacer(flex: 4,),
                      ],
                    ),
                  ),
                )
            ),
          );}
    );
  }
}