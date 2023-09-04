import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:phincash/src/auth/forget_password/forgot_password_views/forget_password.dart';
import 'package:phincash/widget/pin_code_widget.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/asset_path.dart';
import '../../../../constants/colors.dart';
import '../../../loan_transaction/transactions/transaction_views/home_screen.dart';
class InputLoginPin extends StatefulWidget {
  const InputLoginPin({Key? key}) : super(key: key);

  @override
  State<InputLoginPin> createState() => _InputLoginPinState();
}

class _InputLoginPinState extends State<InputLoginPin> {

  Widget _inputLoginPinWidget(){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(flex: 2,),
        SvgPicture.asset(AssetPath.logoStamp, colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn), width: 200,),
        const Spacer(),
        Text(AppString.welcomeBack, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor, fontSize: 35, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
        const SizedBox(height: 10,),
        Text("Kunle!", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor, fontSize: 35, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
        const SizedBox(height: 20,),
        ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2, minHeight: 50),
            child: Text(AppString.forgetPinMessage, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18,fontFamily: AppString.latoFontStyle, color: Colors.black45),)),
        const Spacer(flex: 2,),
        PinCodeWidget(
          onChanged: (value){},
          onCompleted: (String value){
            Get.to(()=>const HomeScreen());
          },
        ),
        const SizedBox(height: 15,),
        Align(alignment: Alignment.center,
            child: InkWell(
                onTap: (){
                  Get.to(()=> const ForgotPassword());
                },
                child: Text(AppString.forgotPassword, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w400, color: kPrimaryColor),))),
        const SizedBox(height: 35,),
        Align(alignment: Alignment.bottomCenter,
          child: RichText(textAlign: TextAlign.center, text: const TextSpan(text: "${AppString.not} Kunle?  ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontFamily: AppString.latoFontStyle, fontSize: 16,),
              children: [
                TextSpan(text: AppString.signOut, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, decoration: TextDecoration.underline)),
              ]
          )),
        ),
        const Spacer(flex: 10,),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(resizeToAvoidBottomInset: false,
          body: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.center, colors: gradientColor,),),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
              child: _inputLoginPinWidget()
            ),
          ),
        )
    );
  }
}
