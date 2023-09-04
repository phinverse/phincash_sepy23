import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phincash/src/auth/login/controller/login_controller.dart';
import 'package:phincash/widget/pin_code_widget.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/asset_path.dart';
import '../../../../constants/colors.dart';
import '../../../../widget/button_widget.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({Key? key}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {


  final _controller = Get.find<LoginController>();

  Widget _instantLoan(){
    return GetBuilder<LoginController>(builder: (controller){
      return Form(
        key: _controller.formKeyOtp,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2,),
            Row(
              children: [
                InkWell(
                    onTap: (){
                      Get.back();
                      // _controller.moveBackToCreateAccountScreen();
                    }, child: const Icon(Icons.arrow_back_ios, size: 25,)
                ),
                // const Spacer(flex: 1,),
                // ...TabIndicatorModel().tabIndicatorWidget.map((element) => Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //   child: element,
                // )).toList(),
                const Spacer(flex: 1,),
              ],
            ),
            Align(alignment: Alignment.centerLeft,
                child: Image.asset(AssetPath.pngSplash, height: 100, width: 100,)),
            const Spacer(),
            Text(AppString.instantLoan, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor, fontSize: 25, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
            const SizedBox(height: 20,),
            Row(
              children: [
                const Icon(Icons.timer_outlined, color: Colors.black45,), const SizedBox(width: 8,),
                Text(AppString.getApproved, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13, fontFamily: AppString.latoFontStyle),),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                const Icon(Icons.timelapse_outlined, color: Colors.black45,), const SizedBox(width: 8,),
                Text(AppString.elaspedTime, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13, fontFamily: AppString.latoFontStyle),),
              ],
            ),
            const Spacer(flex: 1,),
            Text(AppString.inputCode, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
            const SizedBox(height: 10,),
            RichText(textAlign: TextAlign.center, text: TextSpan(text: AppString.codeSent, style: const TextStyle(color: Colors.black45,
              fontFamily: AppString.latoFontStyle, fontSize: 12,), children: [
              TextSpan(text: _controller.phoneNumber, style: const TextStyle(color: kPrimaryColor,fontWeight: FontWeight.w400, fontSize: 12)),]
            )),
            const SizedBox(height: 30,),
            PinCodeWidget(
              onChanged: (value){},
              controller: _controller.otpController,
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
                child: Text(AppString.smsVoid, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle, fontSize: 12),)),
            const SizedBox(height: 24,),
            Align(alignment: Alignment.center,
                child: SvgPicture.asset(AssetPath.sms, height: 55, theme: const SvgTheme(fontSize: 25),)),
            const SizedBox(height: 10,),
            Align(alignment: Alignment.center,
                child: InkWell(onTap: (){
                  _controller.checkConnectionForResendOTP();
                },
                    child: Text(AppString.resendCode, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor, fontSize: 14, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),))),
            const Spacer(flex: 5,),
            ButtonWidget(
                onPressed: (){
                  _controller.checkConnectionForVerifyingOTP();
                },
                buttonText: AppString.continueBtnTxt,
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
    return GetBuilder<LoginController>(
      init: LoginController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(resizeToAvoidBottomInset: false, key: _controller.scaffoldKeyOtpScreen,
            body: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.center, colors: gradientColor,),
                ),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                    child: _instantLoan()
                )
            ),
          )
      );
    });
  }
}
