import 'package:flutter/material.dart';

class LoanExtensionWidget extends StatefulWidget {
  final Widget? subTitle;
  final Widget? title;
  final Widget? tail;
  final Decoration? decoration;
  final void Function(Object?)? onChanged;
  final Object? groupValue;
  final Color? activeColor;
  const LoanExtensionWidget({Key? key, this.subTitle, this.title, this.tail, this.decoration, this.onChanged, this.groupValue, this.activeColor}) : super(key: key);

  @override
  State<LoanExtensionWidget> createState() => _LoanExtensionWidgetState();
}

class _LoanExtensionWidgetState extends State<LoanExtensionWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Radio(value: "Male", groupValue: widget.groupValue,
          onChanged: widget.onChanged,
          activeColor: widget.activeColor,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(height: 65, width: MediaQuery.of(context).size.width / 1.3,
            padding: const EdgeInsets.all(10),
            decoration: widget.decoration,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.title!,
                    const SizedBox(height: 5,),
                   widget.subTitle!,
                  ],
                ),
                widget.tail!,
              ],
            ),
          ),
        )
      ],
    );
  }
}
