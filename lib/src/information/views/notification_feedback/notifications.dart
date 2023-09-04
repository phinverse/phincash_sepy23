import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:phincash/constants/app_string.dart';
import 'package:phincash/src/information/widget/notification_tile_widget.dart';
import 'package:phincash/src/loan_transaction/models/dummy_models.dart';
import 'package:phincash/src/loan_transaction/transactions/controller/transaction_controller.dart';
import '../../../../constants/asset_path.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List _notifications = DummyData.notifications;
  final _controller = Get.find<TransactionController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(
      init: TransactionController(),
        builder: (controller){
      return SafeArea(bottom: false, top: false,
          child: Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
              title: Text(AppString.notification,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
              leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black,size: 20,)),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(24.0,24.0,24.0, 0.0),
              child: _controller.notifications == null || _controller.notifications!.isEmpty || _controller.notifications == []?
              Align(alignment: Alignment.center,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Align(alignment: Alignment.topLeft, child: Text(AppString.transactions, style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black45, fontSize: 14, fontFamily: AppString.latoFontStyle),)),
                    const SizedBox(height: 10,),
                    SvgPicture.asset(AssetPath.noNotification, height: 80, theme: const SvgTheme(fontSize: 25),),
                    const SizedBox(height: 10,),
                    Text("No notification yet", style: Theme.of(context).textTheme.bodyMedium?.copyWith( fontSize: 14, fontFamily: AppString.latoFontStyle),),
                    const SizedBox(height: 20,),
                    Text("They will appear once there’s any", style: Theme.of(context).textTheme.bodyMedium?.copyWith( fontSize: 14, fontFamily: AppString.latoFontStyle, color: Colors.black45),),
                  ],
                ),
              ) :
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.allNotifications, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12, fontFamily: AppString.latoFontStyle),),
                    ...List.generate(_controller.notifications!.length, (index){
                      return NotificationTileWidget(height: 180,
                          notificationLogo:  Image.asset("assets/png_assets/splash_logo.png", height: 60, width: 60,),
                          title: Text(AppString.msgFromPhincash, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF3A3A3A), fontSize: 12),),
                          subTitle: Text(_controller.notifications![index].data!.notificationType!.replaceAll("_", "  ").toString().toUpperCase(),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontSize: 8, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w600),),
                          notificationMessage: Text(_controller.notifications![index].data!.notificationText!,
                            overflow: TextOverflow.fade, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF3A3A3A), fontFamily: AppString.latoFontStyle, fontSize: 12),));
                    }),
                    const Divider()
                  ],
                ),
            ),
            ),
          )
      );
    });
  }
}
