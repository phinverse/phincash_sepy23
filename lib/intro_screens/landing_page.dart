import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:phincash/constants/app_string.dart';
import 'package:phincash/constants/colors.dart';
import 'package:phincash/intro_screens/access_permission.dart';
import 'package:phincash/src/auth/login/login_views/login.dart';
import 'package:phincash/src/information/views/privacy_policy/controller/policy_and_privacy_controller.dart';
import 'package:phincash/utils/helpers/flushbar_helper.dart';
import 'package:phincash/widget/bottom_sheet.dart';
import 'package:phincash/widget/button_widget.dart';
import 'package:phincash/widget/custom_outlined_button.dart';
import '../constants/asset_path.dart';
import '../src/information/views/privacy_policy/policy_policy_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _controller = Get.find<PrivacyPolicyController>();


  void myBottomSheet(){
    MyBottomSheet().showNonDismissibleBottomSheet(context: context, children: [
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GetBuilder<PrivacyPolicyController>(
          init: PrivacyPolicyController(),
            builder: (controller){
          return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.centerLeft,
                  child: Text("User Privacy Agreement", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, fontSize: 18, fontWeight: FontWeight.w700),)),
              const SizedBox(height: 30,),
              Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _controller.policyResponseData?.data?.body == null ?
                  Container(height: MediaQuery.of(context).size.height / 3, width: double.maxFinite,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: WillPopScope(
                        child:Center(
                          child: Stack(
                            children: [
                              Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AssetPath.loading, theme: const SvgTheme(fontSize: 25), height: 25, width: 25,),
                                ],
                              ),
                              ),
                              Center(
                                child: Container(height: 50, width: 50, color: Colors.transparent,
                                  child: CircularProgressIndicator(strokeWidth: 0.9, color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onWillPop: () => Future.value(false)),
                  ) :
                  RichText(
                    text: TextSpan(text: "${_controller.policyResponseData?.data?.body}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13, fontFamily: AppString.latoFontStyle, color: Colors.black),),
                  ),
                  const SizedBox(height: 5,),
                  RichText(textAlign: TextAlign.left, text: TextSpan(
                      text: "Please read the ", style: TextStyle(color: Colors.black, fontFamily: AppString.latoFontStyle, fontSize: 13,),
                      children: [
                        TextSpan(text: "Terms of Service", recognizer: TapGestureRecognizer()..onTap = () => Get.to(()=>const TermsAndConditions()),style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: kPrimaryColorLight, fontFamily: AppString.latoFontStyle)),
                        TextSpan(text: " and", style: TextStyle(fontSize: 11,fontFamily: AppString.latoFontStyle)),
                        TextSpan(text: " Privacy Policy", recognizer: TapGestureRecognizer()..onTap = () => Get.to(()=>const TermsAndConditions()),style: TextStyle(fontSize: 13,fontFamily: AppString.latoFontStyle,color: kPrimaryColorLight, fontWeight: FontWeight.w800)),
                        TextSpan(text: " to enjoy our services", style: TextStyle(fontSize: 13,fontFamily: AppString.latoFontStyle, )),
                      ]
                  )),
                  const SizedBox(height: 20,),
                  ButtonWidget(
                      onPressed: (){
                        Get.back();
                      },
                      buttonText: "Agree", buttonColor: kPrimaryColor,
                      height: 55, width: double.maxFinite
                  ),
                  const SizedBox(height: 20,),
                  CustomOutlineButton(
                      text: "Disagree", height: 55,
                      onPressed: (){
                        SystemNavigator.pop();
                      }),
                  const SizedBox(height: 30,),
                ],
              ),
            ],
          );
        })
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20,10,20,30),
            child: Column(
              children: [
                const Spacer(flex: 9,),
                Align(alignment: Alignment.center,
                    child: Image.asset(AssetPath.pngSplash, height: 100, width: 400,)
                  //SvgPicture.asset(AssetPath.logoStamp, theme: const SvgTheme(fontSize: 25),),
                ),
                const Spacer(flex: 9,),
                ButtonWidget(
                    onPressed: (){
                      _controller.policyResponseData?.data?.body == null ? FlushBarHelper(context).showFlushBar("Policy and Privacy not fully loaded", color: kPrimaryColorLight) :
                      Get.to(()=> const AccessPermissionPage());
                      }, buttonText: AppString.signMeUp,
                    height: 48, width: double.maxFinite
                ),
                const SizedBox(height: 40,),
                InkWell(onTap: (){
                  Get.to(()=>const Login());
                },
                  child: RichText(textAlign: TextAlign.center, text: const TextSpan(
                      text: AppString.alreadyHaveAccount, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontFamily: AppString.latoFontStyle, fontSize: 13,),
                      children: [
                        TextSpan(text: AppString.login, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, decoration: TextDecoration.underline)),
                      ]
                  )),
                ),
                const Spacer(),
              ],
            ),
          ),
        )
    );
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 1), () => myBottomSheet(),
    );
    super.initState();
  }
}

