import 'package:flutter/material.dart';
import 'package:phincash/constants/app_string.dart';

class TransactionHistoryTile extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? payment;
  final Widget? date;
  final Widget? amount;
  final Widget? status;

  const TransactionHistoryTile(
      {Key? key,
      this.height,
      this.width,
      this.payment,
      this.date,
      this.amount,
      this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: height ?? 135,
      width: width ?? double.maxFinite,
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PAYMENT",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                            fontFamily: AppString.latoFontStyle,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      payment!,
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DATE",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                            fontFamily: AppString.latoFontStyle,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      date!,
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AMOUNT",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                            fontFamily: AppString.latoFontStyle,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      amount!,
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "STATUS",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                            fontFamily: AppString.latoFontStyle,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      status!,
                    ],
                  ),
                ],
              ),
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
