import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phincash/constants/app_string.dart';
import 'package:phincash/constants/asset_path.dart';
import 'package:phincash/src/auth/registration/registration_views/create_account.dart';
import 'package:phincash/widget/button_widget.dart';

class AccessPermissionPage extends StatelessWidget {
  const AccessPermissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20,10,20,30),
            child: Column(
              children: [
                const Spacer(flex: 9,),
                Align(alignment: Alignment.center,
                    child: SvgPicture.asset(AssetPath.grantAccess, theme: const SvgTheme(fontSize: 25),)),
                const Spacer(flex: 6,),
                RichText(textAlign: TextAlign.center, text: const TextSpan(
                    text: AppString.accessPageHeader, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20,fontFamily: AppString.latoFontStyle)
                )),
                const Spacer(),
                RichText(textAlign: TextAlign.center, text: const TextSpan(
                    text: AppString.accessPageMessage, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13,fontFamily: AppString.latoFontStyle)
                )),
                const Spacer(),
                ButtonWidget(
                    onPressed: (){ Get.offAll(()=> const CreatePhinCashAccount());},
                    buttonText: AppString.grantAccess, height: 48, width: double.maxFinite
                ),
                const Spacer(),
              ],
            ),
          ),
        )
    );
  }
}
