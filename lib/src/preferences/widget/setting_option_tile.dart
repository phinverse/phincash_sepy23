import 'package:flutter/material.dart';
class SettingOptionTile extends StatelessWidget {
  final Widget? optionTitle;
  final Widget? destinationIcon;
  final void Function()? onTap;
  const SettingOptionTile({Key? key, this.optionTitle, this.destinationIcon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0,20.0,10.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              optionTitle!,
              const Spacer(flex: 13,),
              InkWell(onTap: (){onTap;},
                  child: destinationIcon),
              const Spacer(),
            ],
          ),
          const Divider(color: Colors.black12, thickness: 0.3,),
        ],
      ),
    );
  }
}
