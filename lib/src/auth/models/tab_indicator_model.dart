import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import 'package:get/get.dart';
import '../registration/controller/registration_controller.dart';

class TabIndicatorModel{

  List<Widget> tabIndicatorWidget = [
    GetBuilder<RegistrationController>(
      init: RegistrationController(),
        builder: (controller){
      return Container(width: 60, height: 6,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            color: controller.isVerifyNumberScreen == true && controller.isVerifyOtpScreen == false && controller.isCompleteSignUpScreen == false ? kPrimaryColor :
            controller.isVerifyNumberScreen == true && controller.isVerifyOtpScreen == true && controller.isCompleteSignUpScreen == false ? kPrimaryColor :
            controller.isVerifyNumberScreen == true && controller.isVerifyOtpScreen == true && controller.isCompleteSignUpScreen == true ? kPrimaryColor : kGrey
        ),
      );
    }),
    GetBuilder<RegistrationController>(
        init: RegistrationController(),
        builder: (controller){
      return Container(width: 60, height: 6,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
          color:  controller.isVerifyNumberScreen == true && controller.isVerifyOtpScreen == true && controller.isCompleteSignUpScreen == false ? kPrimaryColor :
          controller.isVerifyNumberScreen == true && controller.isVerifyOtpScreen == true && controller.isCompleteSignUpScreen == true ? kPrimaryColor : kGrey,
        ),
      );
    }),
   GetBuilder<RegistrationController>(
       init: RegistrationController(),
       builder: (controller){
     return  Container(width: 60, height: 6,
       margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
         color: controller.isVerifyNumberScreen == true && controller.isVerifyOtpScreen == true && controller.isCompleteSignUpScreen == true ? kPrimaryColor :
         kGrey,
       ),
     );
   })
  ];
}