import 'package:flutter/material.dart';
import 'package:phincash/constants/colors.dart';

class ProfileTileWidget extends StatelessWidget {
  final IconData? icon;
  final Widget? title;
  final IconData? destinationIcon;
  final Color? iconColor;
  const ProfileTileWidget({Key? key, this.icon, this.title, this.destinationIcon, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0,10.0,20.0,10.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon!, size: 20, color: iconColor ?? kPrimaryColor,),
              const Spacer(),
              title!,
              const Spacer(flex: 6,),
              Icon(destinationIcon!,size: 15,),
              const Spacer(),
            ],
          ),
          const Divider(color: Colors.black12, thickness: 0.3,),
        ],
      ),
    );
  }
}
