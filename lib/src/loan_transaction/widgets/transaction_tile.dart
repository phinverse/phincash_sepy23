import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final Widget? image;
  final Widget? title;
  final Widget? subTitle;
  final Widget? amount;
  final double? height;
  final double? width;
  final double? padding;

  const TransactionTile(
      {Key? key,
      this.image,
      this.title,
      this.subTitle,
      this.amount,
      this.height,
      this.width,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 100,
      width: width ?? double.maxFinite,
      padding: EdgeInsets.all(padding ?? 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image!,
          const Spacer(
            flex: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              title!,
              const SizedBox(
                height: 5,
              ),
              subTitle!.toString().isNotEmpty
                  ? subTitle!
                  : const SizedBox.shrink(),
              const Spacer(),
            ],
          ),
          const Spacer(
            flex: 4,
          ),
          amount!,
          const Spacer(),
        ],
      ),
    );
  }
}
