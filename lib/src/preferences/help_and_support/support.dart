import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phincash/constants/asset_path.dart';
import 'package:phincash/constants/colors.dart';
import 'package:phincash/src/information/views/privacy_policy/controller/policy_and_privacy_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../constants/app_string.dart';
class SupportAndHelp extends StatelessWidget {
  const SupportAndHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(PrivacyPolicyController());
    void _launchEmail() async {
      final Uri params = Uri(
        scheme: 'mailto',
        path: _controller.appSettingsResponseData?.data?.contactEmail ?? 'customercare@phincash.com',
      );
      String  url = params.toString();
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        print( 'Could not launch $url');
      }
    }
    return GetBuilder<PrivacyPolicyController>(
      init: PrivacyPolicyController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
              appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
                title: Text("Support",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
                leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black,size: 20,)),
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(24.0,0.0,24.0,0.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30,),
                    Text("We are here to help you !",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontFamily: AppString.latoFontStyle, color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10,),
                    ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5, minHeight: 50),
                        child: Text("Need help? Or got a problem? Reach us via any of our platforms below",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black54, fontWeight: FontWeight.w500),)),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: ()async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: _controller.appSettingsResponseData?.data?.contactPhone ?? "+2348787899087",
                        );
                        await launchUrl(launchUri);
                        if (!await launchUrl(launchUri)) throw 'Could not launch $launchUri';
                      },
                      child: ListTile(
                        leading: SvgPicture.asset(AssetPath.phone, height: 40, width: 40,),
                        title: Text("Give us a call on", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: AppString.latoFontStyle),),
                        subtitle: Text("${_controller.appSettingsResponseData?.data?.contactPhone ?? "+2348787899087"}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: AppString.latoFontStyle, color: kPrimaryColor),),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    InkWell(
                      onTap: ()async {
                        _launchEmail();
                      },
                      child: ListTile(
                        leading: SvgPicture.asset(AssetPath.email, height: 40, width: 40,),
                        title: Text("Send us an email at", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: AppString.latoFontStyle),),
                        subtitle: Text("${_controller.appSettingsResponseData?.data?.contactEmail ?? 'customercare@phincash.com'}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: AppString.latoFontStyle, color: kPrimaryColor),),
                      ),
                    ),
                  ],
                ),
              )
          )
      );
    });
  }
}
