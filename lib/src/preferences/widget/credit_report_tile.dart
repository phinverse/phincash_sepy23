import 'package:flutter/material.dart';
class CreditReportTileWidget extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  const CreditReportTileWidget({Key? key, this.leading, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.maxFinite, height: 80,
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            leading!,
            const Spacer(flex: 3,),
            Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title!,
                const SizedBox(height: 10,),
                subtitle!,
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
