import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/src/preferences/controller/reset_pin_controller.dart';
import 'package:phincash/src/preferences/settings_options/reset_pin.dart';
import '../../../constants/app_string.dart';
import '../../../constants/colors.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/pin_code_widget.dart';
class ConfirmPreviousPin extends StatefulWidget {
  const ConfirmPreviousPin({Key? key}) : super(key: key);

  @override
  State<ConfirmPreviousPin> createState() => _ConfirmPreviousPinState();
}

class _ConfirmPreviousPinState extends State<ConfirmPreviousPin> {
  final _resetPinController = Get.put(ResetPinController(), permanent: true);
  final scaffoldKey = GlobalKey <ScaffoldState>();
  final formKey = GlobalKey <FormState>();
  final _previousPinController = TextEditingController();
  Future<void> gotoResetPin() async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      Get.to(()=>const ResetPin());
    }
  }
  Widget _confirmPreviousPin(){
    return GetBuilder<ResetPinController>(
        init: ResetPinController(),
        builder: (controller){
          return Form(
            key: formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 3,),
                Row(
                  children: [
                    InkWell(
                        onTap: (){
                          Get.back();
                        }, child: const Icon(Icons.arrow_back_ios, size: 20,)
                    ),
                    const Spacer(),
                    Text("Reset PIN", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
                    const Spacer(),
                  ],
                ),
                const Spacer(flex: 3,),
                Text("Reset Account PIN", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor, fontSize: 23, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
                const SizedBox(height: 5,),
                ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.4, minHeight: 50),
                    child: Text("Please make sure the PIN is kept personal as this PIN would be used for every of your transaction",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle,),)),
                const SizedBox(height: 5,),
                ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2, minHeight: 50),
                    child: Text("Enter Your current 4 Digits PIN to continue", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black45),)),
                const SizedBox(height: 30,),
                PinCodeWidget(
                  controller: _previousPinController,
                  length: 4,  horizontalPadding: 50,
                  onChanged: (value){
                    _resetPinController.currentPin = _previousPinController.text;
                  },
                  validator: (v) {
                    if(v!.isEmpty){
                      return "Please enter 4-digit pin";
                    } else if (v.length < 4) {
                      return "Pin must be 4 digits";
                    } else {
                      return null;
                    }
                  },
                ),
                const Spacer(flex: 13,),
                ButtonWidget(
                    onPressed: (){
                      gotoResetPin();
                    },
                    buttonText: "Continue",
                    height: 48, width: double.maxFinite
                ),
                const Spacer(flex: 5,),
              ],
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPinController>(
      init: ResetPinController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(key: scaffoldKey, resizeToAvoidBottomInset: false,
            body: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.center, colors: gradientColor,),),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                child: _confirmPreviousPin(),
              ),
            ),
          )
      );
    });
  }
}
