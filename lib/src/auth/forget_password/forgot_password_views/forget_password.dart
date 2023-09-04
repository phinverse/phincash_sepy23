import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/src/auth/forget_password/controller/reset_password_controller.dart';
import 'package:phincash/widget/formfield_widget.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/colors.dart';
import '../../../../widget/button_widget.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _controller = Get.put(ResetPasswordController(), permanent: true);
  Widget _forgotPin(){
    return GetBuilder<ResetPasswordController>(
      init: ResetPasswordController(),
        builder: (controller){
      return Form(
        key: _controller.formKeyForgotPasswordKey,
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
                Text(AppString.forgotPinHeader, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
                const Spacer(),
              ],
            ),
            const Spacer(flex: 8,),
            ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2, minHeight: 50),
                child: Text("Enter the mobile number associated with your account", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18,fontFamily: AppString.latoFontStyle, color: Colors.black45),)),
            const SizedBox(height: 10,),
            FormFieldWidget(
              onChanged: (value){
                setState(() {
                  _controller.phoneNumber = _controller.phoneNumberController.text;
                });
              },
              labelText: AppString.mobileNumber,
              keyboardType: TextInputType.phone,
              controller: _controller.phoneNumberController,
              validator: (value){
                if (value!.isEmpty){
                  return 'Please enter your PhoneNumber';}
                else if (!_controller.phoneValidator.hasMatch(value)){
                  return "Please provide a valid phoneNumber";
                } else {
                  return null;
                }
              },
            ),
            const Spacer(flex: 13,),
            ButtonWidget(
                onPressed: (){
                  _controller.checkConnectionForResetPassword();
                  // Get.to(()=> const VerifyForgotPassword());
                },
                buttonText: AppString.getVerificationCode,
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
    return SafeArea(top: false, bottom: false,
        child: Scaffold(resizeToAvoidBottomInset: false, key: _controller.scaffoldForgotPassword,
          body: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.center, colors: gradientColor,),),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                child: _forgotPin()
            ),
          ),
        )
    );
  }
}
