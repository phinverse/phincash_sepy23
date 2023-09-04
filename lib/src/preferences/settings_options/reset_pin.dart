import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/src/preferences/controller/reset_pin_controller.dart';
import 'package:phincash/src/preferences/settings_options/confirm_reset_pin.dart';
import 'package:phincash/widget/button_widget.dart';
import 'package:phincash/widget/pin_code_widget.dart';
import '../../../constants/app_string.dart';
import '../../../constants/colors.dart';
import '../../../utils/helpers/flushbar_helper.dart';

class ResetPin extends StatefulWidget {
  const ResetPin({Key? key}) : super(key: key);

  @override
  State<ResetPin> createState() => _ResetPinState();
}

class _ResetPinState extends State<ResetPin> {
  final _controller = Get.find<ResetPinController>();
  final scaffoldKey = GlobalKey <ScaffoldState>();
  final formKey = GlobalKey <FormState>();
  final _resetPinController = TextEditingController();
  Future<void> moveToConfirmPin() async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      Get.to(()=>const ConfirmResetPin());
      FlushBarHelper(Get.context!).showFlushBar("PIN is Valid. Please Confirm Pin to Continue", borderColor: Colors.green, messageColor: Colors.green,
          color: Colors.white,icon: Icon(Icons.check_circle, color: Colors.green, size: 30,));
    }
  }
  Widget _resetPin(){
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
            const Spacer(flex: 8,),
            ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2, minHeight: 50),
                child: Text("Enter Your desired 4 Digits PIN to continue",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black45),)),

            const SizedBox(height: 10,),

            PinCodeWidget(
              controller: _resetPinController,
              length: 4,  horizontalPadding: 50,
              onChanged: (value){
                _controller.resetPin = _resetPinController.text;
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
                  moveToConfirmPin();
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
          child: Scaffold(key: scaffoldKey,
            body: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.center, colors: gradientColor,),),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                child: _resetPin(),
              ),
            ),
          )
      );
    });
  }
}
