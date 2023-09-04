import 'package:flutter/material.dart';
class NotificationTileWidget extends StatelessWidget {
  final Widget notificationLogo;
  final Widget title;
  final Widget subTitle;
  final Widget notificationMessage;
  final double? height;
  final double? width;
  const NotificationTileWidget({Key? key, required this.notificationLogo, required this.title, required this.subTitle, required this.notificationMessage, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 5,),
        Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           notificationLogo,
           const SizedBox(width: 20,),
           Expanded(flex: 3,
               child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   title,
                   subTitle,
                   const SizedBox(height: 5,),
                   notificationMessage,
                   const SizedBox(height:5,),
                 ],
               )
           )
         ],
        ),
      ],
    );
  }
}
