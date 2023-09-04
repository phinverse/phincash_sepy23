import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phincash/src/auth/forget_password/controller/reset_password_controller.dart';
import 'package:phincash/widget/pin_code_widget.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/asset_path.dart';
import '../../../../constants/colors.dart';
import '../../../../widget/button_widget.dart';

class VerifyForgotPassword extends StatefulWidget {
  const VerifyForgotPassword({Key? key}) : super(key: key);

  @override
  State<VerifyForgotPassword> createState() => _VerifyForgotPasswordState();
}

class _VerifyForgotPasswordState extends State<VerifyForgotPassword> {


  final _controller = Get.put(ResetPasswordController());

  Widget _instantLoan(){
    return GetBuilder<ResetPasswordController>(
      init: ResetPasswordController(),
        builder: (controller){
      return Form(
        key: _controller.formKeyForgotPasswordOtpVerifyKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2,),
            Row(
              children: [
                InkWell(
                    onTap: (){
                      Get.back();
                    }, child: const Icon(Icons.arrow_back_ios, size: 25,)
                ),
                const Spacer(),
                Text(AppString.mobileNumber, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
                const Spacer()
              ],
            ),
            const Spacer(flex: 5,),
            Text(AppString.inputCode, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
            const SizedBox(height: 10,),
            RichText(textAlign: TextAlign.center, text: TextSpan(text: AppString.codeSent, style: const TextStyle(color: Colors.black45,
              fontFamily: AppString.latoFontStyle, fontSize: 15,), children: [
              TextSpan(text:
                  //text: "08033335555",
             _controller.phoneNumber,
                  style: const TextStyle(color: kPrimaryColor,fontWeight: FontWeight.w400, fontSize: 15)),]
            )),
            const SizedBox(height: 30,),
            PinCodeWidget(
              onChanged: (value){
                setState(() {
                  _controller.code = _controller.codeController.text;
                });
              },
              controller: _controller.codeController,
              validator: (v) {
                if(v!.isEmpty){
                  return "Please enter 6-digit pin";
                } else if (v.length < 6) {
                  return "Pin must be 6 digits";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20,),
            Align(alignment: Alignment.center,
                child: Text(AppString.smsVoid, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle, fontSize: 14),)),
            const SizedBox(height: 24,),
            Align(alignment: Alignment.center,
                child: SvgPicture.asset(AssetPath.sms, height: 55, theme: const SvgTheme(fontSize: 25),)),
            const SizedBox(height: 10,),
            Align(alignment: Alignment.center,
                child: InkWell(onTap: (){
                  _controller.checkConnectionForResendOTP();
                },
                    child: Text(AppString.resendCode, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),))),
            const Spacer(flex: 7,),
            ButtonWidget(
                onPressed: (){
                  // Get.to(()=>const ResetPassword());
                  _controller.checkConnectionForValidateResetPassword();
                },
                buttonText: "Verify",
                height: 48, width: double.maxFinite
            ),
            const Spacer(flex: 3,),
          ],
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
      init: ResetPasswordController(),
        builder: (controller){
          return SafeArea(top: false, bottom: false,
              child: Scaffold(resizeToAvoidBottomInset: false, key: _controller.scaffoldForgotPasswordOtpVerifyKey,
                body: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.center, colors: gradientColor,),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(26.0, 0.0, 26.0, 0.0),
                        child: _instantLoan()
                    )
                ),
              )
          );
        });
  }
}
