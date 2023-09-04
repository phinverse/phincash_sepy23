import 'package:flutter/material.dart';

import '../../../../constants/app_string.dart';
import '../../../../constants/colors.dart';
import '../../../../widget/button_widget.dart';
import '../../../../widget/formfield_widget.dart';
import '../controller/reset_password_controller.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final _controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    Widget _resetPassword(){
      return GetBuilder<ResetPasswordController>(
          init: ResetPasswordController(),
          builder: (controller){
            return Form(
              key: _controller.formKeyResetPasswordKey,
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
                  const Spacer(flex: 6,),

                  ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2, minHeight: 50),
                      child: Text("Enter a new password and confirm", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18,fontFamily: AppString.latoFontStyle, color: Colors.black45),)),
                  const SizedBox(height: 10,),
                  FormFieldWidget(
                    labelText: AppString.newPassword,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _controller.newPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }else if (value.length < 8) {
                        return 'Password must be up to 8 characters';
                      } else if (!value.contains(RegExp(r"[A-Z]"))){
                        return 'Password must contain at least one uppercase';
                      }else if (!value.contains(RegExp(r"[a-z]"))){
                        return 'Password must contain at least one lowercase';
                      }else if (!value.contains(RegExp(r"[0-9]"))){
                        return 'Password must contain at least one number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30,),
                  FormFieldWidget(
                    labelText: AppString.confirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _controller.confirmPasswordController,
                    validator: (value){
                      if (value!.isEmpty){
                        return 'Please enter your password';}
                      else if (value != _controller.newPasswordController.text){
                        return "Password do not match";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const Spacer(flex: 13,),
                  ButtonWidget(
                      onPressed: (){
                        _controller.checkConnectionForResetAccountPassword();
                      },
                      buttonText: AppString.resetMyPassword,
                      height: 48, width: double.maxFinite
                  ),
                  const Spacer(flex: 5,),
                ],
              ),
            );
          });
    }
    return SafeArea(top: false, bottom: false,
      child: Scaffold(key: _controller.scaffoldResetPassword, resizeToAvoidBottomInset: false,
        body: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.center, colors: gradientColor,),),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
              child: _resetPassword()
          ),
        ),
      ),
    );
  }
}
