import 'package:flutter/material.dart';
import 'package:phincash/constants/colors.dart';

class CustomOutlineButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final double? height;
  final TextStyle? style;
  final Color? color;
  final double? buttonBorderRadius;
  final Color? backGroundColor;
  const CustomOutlineButton({Key? key, required this.text, required this.onPressed, this.height, this.style, this.color, this.buttonBorderRadius, this.backGroundColor}) : super(key: key);

  @override
  _CustomOutlineButtonState createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: Text(widget.text, style:  widget.style ?? Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor,fontSize: 14, fontWeight: FontWeight.bold,)),
      style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(widget.height ?? 50)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                side: BorderSide(
                  color: widget.color ?? kPrimaryColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.buttonBorderRadius ?? 10.0),
                ),
              )),
          backgroundColor: MaterialStateProperty.all<Color>(widget.backGroundColor ?? Colors.white)
      ),
    );
  }
}
