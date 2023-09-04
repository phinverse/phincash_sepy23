import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/src/auth/forget_password/forgot_password_views/forget_password.dart';
import 'package:phincash/src/auth/login/controller/login_controller.dart';
import 'package:phincash/src/auth/registration/registration_views/create_account.dart';
import 'package:phincash/widget/formfield_widget.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/asset_path.dart';
import '../../../../constants/colors.dart';
import '../../../../widget/button_widget.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _controller = Get.put(LoginController());
  Widget _loginWidget(){
    return GetBuilder<LoginController>(
      init: LoginController(),
        builder: (controller){
      return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 2,),
          Align(alignment: Alignment.centerLeft,
              child: Image.asset(AssetPath.pngSplash, height: 100, width: 100,)),
          // SvgPicture.asset(AssetPath.logoStamp, color: kPrimaryColor,width: 200,),
          const Spacer(),
          Text(AppString.welcomeNote, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor, fontSize: 25, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
          const SizedBox(height: 20,),
          ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2, minHeight: 50),
              child: Text(AppString.welcomeNoteMessage, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13,fontFamily: AppString.latoFontStyle, color: Colors.black45),)),
          //Text(AppString.mobileNumber, style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
          const SizedBox(height: 15,),
          FormFieldWidget(
            onChanged: (String value){
              setState(() {
                _controller.phoneNumber = _controller.phoneNumberController.text;
              });
            },
            labelText: AppString.mobileNumber,
            controller: _controller.phoneNumberController,
            keyboardType: TextInputType.phone,
            // validator: (value){
            //   if (value!.isEmpty){
            //     return 'Please enter your PhoneNumber';}
            //   else if (!_controller.phoneValidator.hasMatch(value)){
            //     return "Please provide a valid phoneNumber";
            //   } else {
            //     return null;
            //   }
            // },
          ),
          const SizedBox(height: 30,),
          //Text(AppString.pin, style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
          const SizedBox(height: 15,),
          FormFieldWidget(
            controller: _controller.passwordController,
            suffixIcon: IconButton(onPressed: (){
              _controller.toggleVisibility();
            }, icon: _controller.isPasswordObscured == true ?
            const Icon(Icons.visibility_off, size: 25, color: Colors.black54,): const Icon(Icons.visibility, size: 25, color: Colors.black54,)),
            obscureText: _controller.isPasswordObscured,
            keyboardType: TextInputType.visiblePassword,
            labelText: AppString.password,
            // validator: (value) {
            //   if (value!.isEmpty) {
            //     return 'Please enter password';
            //   }else if (value.length < 8) {
            //     return 'Password must be up to 8 characters';
            //   }
            //   else if (!value.contains(RegExp(r"[A-Z]"))){
            //     return 'Password must contain at least one uppercase';
            //   }
            //   else if (!value.contains(RegExp(r"[a-z]"))){
            //     return 'Password must contain at least one lowercase';
            //   }else if (!value.contains(RegExp(r"[0-9]"))){
            //     return 'Password must contain at least one number';
            //   }
            //   return null;
            // },
          ),
          const Spacer(flex: 3,),
          ButtonWidget(
              onPressed: (){
                // Get.to(()=>const HomeScreen());
                _controller.checkConnectionForLogin();
              },
              buttonText: AppString.loginNoSpace,
              height: 48, width: double.maxFinite
          ),
          const Spacer(flex: 1,),
          Align(alignment: Alignment.center,
              child: InkWell(
                  onTap: (){
                    Get.to(()=>const ForgotPassword());
                  },
                  child: Text(AppString.forgotPassword, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w400, color: kPrimaryColor),))),
          const Spacer(flex: 8,),
          Align(alignment: Alignment.bottomCenter,
            child: InkWell(onTap: (){Get.to(()=> const CreatePhinCashAccount());},
              child: RichText(textAlign: TextAlign.center, text: const TextSpan(text: AppString.newToPhinCash, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontFamily: AppString.latoFontStyle, fontSize: 13,),
                  children: [
                    TextSpan(text: AppString.signUp, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, decoration: TextDecoration.underline)),
                  ]
              )),
            ),
          ),
          const Spacer(),
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: GetBuilder<LoginController>(
          init: LoginController(),
            builder: (controller){
          return Scaffold(resizeToAvoidBottomInset: false,
            //key: _controller.scaffoldKey,
            body: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.center, colors: gradientColor,),),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                child: _loginWidget(),
              ),
            ),
          );
        })
    );
  }
}
