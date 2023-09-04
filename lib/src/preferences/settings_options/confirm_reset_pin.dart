import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/src/preferences/controller/reset_pin_controller.dart';
import 'package:phincash/widget/button_widget.dart';
import 'package:phincash/widget/pin_code_widget.dart';
import '../../../constants/app_string.dart';
import '../../../constants/colors.dart';

class ConfirmResetPin extends StatefulWidget {
  const ConfirmResetPin({Key? key}) : super(key: key);

  @override
  State<ConfirmResetPin> createState() => _ConfirmResetPinState();
}

class _ConfirmResetPinState extends State<ConfirmResetPin> {
  final _controller = Get.find<ResetPinController>();
  final scaffoldKey = GlobalKey <ScaffoldState>();
  final formKey = GlobalKey <FormState>();
  final _confirmResetPinController = TextEditingController();
  Future<void> changePinNow() async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      print(_controller.resetPin);
      print(_controller.confirmResetPin);
      print(_controller.currentPin);
      _controller.changePin();
    }
  }
  Widget _confirmResetPin(){
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
                        }, child: const Icon(Icons.arrow_back_ios, size: 25,)
                    ),
                    const Spacer(),
                    Text("Reset PIN", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
                    const Spacer(),
                  ],
                ),
                const Spacer(flex: 8,),
                ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2, minHeight: 50),
                    child: Text("Confirm Your desired 4 Digits PIN to continue", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18,fontFamily: AppString.latoFontStyle, color: Colors.black45),)),
                const SizedBox(height: 10,),
                PinCodeWidget(
                  controller: _confirmResetPinController,
                  length: 4,  horizontalPadding: 50,
                  onChanged: (value){
                    _controller.confirmResetPin = _confirmResetPinController.text;
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
                      changePinNow();
                    },
                    buttonText: "Reset PIN",
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
                    child: _confirmResetPin(),
                  ),
                ),
              )
          );
        });
  }
}
