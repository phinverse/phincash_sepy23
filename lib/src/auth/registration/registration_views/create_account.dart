import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/constants/app_string.dart';
import 'package:phincash/constants/colors.dart';
import 'package:phincash/src/auth/login/login_views/login.dart';
import 'package:phincash/widget/button_widget.dart';
import 'package:phincash/widget/formfield_widget.dart';
import '../../../../constants/asset_path.dart';
import '../../../information/views/privacy_policy/policy_policy_screen.dart';
import '../controller/registration_controller.dart';

class CreatePhinCashAccount extends StatefulWidget {
  const CreatePhinCashAccount({Key? key}) : super(key: key);

  @override
  State<CreatePhinCashAccount> createState() => _CreatePhinCashAccountState();
}

class _CreatePhinCashAccountState extends State<CreatePhinCashAccount> {
  final _controller = Get.put(RegistrationController(), permanent: true);

  Widget _verifyNumberWidget(){
    return GetBuilder<RegistrationController>(
      init: RegistrationController(),
        builder: (controller){
      return Form(
        key: _controller.formKeySignUp,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2,),
            Row(
              children: [
                InkWell(
                    onTap: (){
                      Get.back();
                    }, child: const Icon(Icons.arrow_back_ios, size: 20,)
                ),
               // const Spacer(flex: 1,),
               //  ...TabIndicatorModel().tabIndicatorWidget.map((element) => Padding(
               //    padding: const EdgeInsets.symmetric(horizontal: 8.0),
               //    child: element,
               //  )).toList(),
                const Spacer(flex: 1,),
              ],
            ),
            Align(alignment: Alignment.centerLeft,
                child: Image.asset(AssetPath.pngSplash, height: 100, width: 100,)),
            const Spacer(),
            Text(AppString.createAccount, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor, fontSize: 25, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
            const SizedBox(height: 15,),
            ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2, minHeight: 50),
                child: Text(AppString.verifyNumberMessage, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle,),)),
            const Spacer(),
            //Text(AppString.mobileNumber, style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
            //const SizedBox(height: 10,),
            Text(AppString.checkBVNMessage, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontSize: 14, fontFamily: AppString.latoFontStyle),),
            const SizedBox(height: 15,),
            FormFieldWidget(
              controller: _controller.phoneNumberController,
              keyboardType: TextInputType.phone,
              labelText: AppString.mobileNumber,
              onChanged: (value){
                _controller.bvnPhoneNumberController.text = value;
              },
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
            const SizedBox(height: 45,),
            FormFieldWidget(
              suffixIcon: IconButton(onPressed: (){
                _controller.toggleVisibility();
              }, icon: _controller.isPasswordObscured == true ?
              const Icon(Icons.visibility_off, size: 25, color: Colors.black54,): const Icon(Icons.visibility, size: 25, color: Colors.black54,)),
              obscureText: _controller.isPasswordObscured,
              controller: _controller.passwordController,
              keyboardType: TextInputType.visiblePassword,
              labelText: AppString.password,
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
            const SizedBox(height: 35,),
            Row(
              children: [
               Expanded(
                 child: Row(
                   children: [
                     InkWell(
                       onTap: (){
                         _controller.selectTermsAndCondition();
                       },
                       child: Row(mainAxisSize: MainAxisSize.max,
                         children: [
                           _controller.isTermsAndConditionSelected? Container(height: 15, width: 15,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(3),
                                 color: kPrimaryColor
                             ),
                             child: const Center(child: Icon(Icons.check, size: 10, color: Colors.white,)),
                           ) : Container(height: 15, width: 15,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(3),
                                 border: Border.all(width: 2, color: const Color(0xFFDADADA))
                             ),
                           ),
                           const SizedBox(width: 15,),
                         ],
                       ),
                     ),
                     RichText(textAlign: TextAlign.center, text: TextSpan(text: AppString.agreed, style: TextStyle(color: Colors.black45,
                       fontFamily: AppString.latoFontStyle, fontSize: 11,overflow: TextOverflow.ellipsis), children: [
                       TextSpan(text: AppString.userService, recognizer: TapGestureRecognizer()..onTap = () => Get.to(()=>const TermsAndConditions()),
                           style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.w400, fontSize: 12, overflow: TextOverflow.ellipsis)),
                       TextSpan(text: AppString.agreement, style: TextStyle(color: Colors.black45, fontSize: 11, overflow: TextOverflow.ellipsis))]
                     ))
                   ],
                 ),
               )
              ],
            ),
            const Spacer(flex: 8,),
            ButtonWidget(
                onPressed: (){
                  _controller.signUp();
                },
                buttonText: AppString.getVerificationCode,
                height: 48, width: double.maxFinite
            ),
            const SizedBox(height: 40,),
            Align(alignment: Alignment.bottomCenter,
              child: InkWell(onTap: (){
                Get.to(()=>const Login());
              },
                child: RichText(textAlign: TextAlign.center, text: const TextSpan(text: AppString.alreadyHaveAccount, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontFamily: AppString.latoFontStyle, fontSize: 12,),
                    children: [
                      TextSpan(text: AppString.login, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, decoration: TextDecoration.underline)),
                    ]
                )),
              ),
            ),
            const SizedBox(height: 40,),
            Align(alignment: Alignment.bottomCenter,
              child: RichText(textAlign: TextAlign.center, text: TextSpan(text: AppString.agreedConfirmation, style: TextStyle(color: Colors.black45,
                fontFamily: AppString.latoFontStyle, fontSize: 12,), children: [
                TextSpan(text: AppString.termsOfServices, recognizer: TapGestureRecognizer()..onTap = () => Get.to(()=>const TermsAndConditions()), style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.w400)),
                TextSpan(text: AppString.and, style: TextStyle(color: Colors.black45)),
                TextSpan(text: AppString.privacyPolicy, recognizer: TapGestureRecognizer()..onTap = () => Get.to(()=>const TermsAndConditions()),style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
              ]
              )),
            ),
            const Spacer(flex: 1,),
          ],
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(resizeToAvoidBottomInset: false,key: _controller.scaffoldKey,
            backgroundColor: Colors.white,
            body: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.center, colors: gradientColor,),
                ),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                    child: _verifyNumberWidget()
                )
            ),
          )
      );
    });
  }
}

