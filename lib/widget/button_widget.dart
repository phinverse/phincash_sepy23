import 'package:flutter/material.dart';
import '../constants/colors.dart';
class ButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  final Color? buttonColor;
  final double? height;
  final double width;
  final TextStyle? buttonTextStyle;
  const ButtonWidget({Key? key,required this.onPressed,required this.buttonText, this.buttonColor, required this.height, required this.width, this.buttonTextStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(height: height ?? 65, width: double.maxFinite,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: buttonColor ?? kPrimaryColor, ),
            onPressed: onPressed,
            child: Text(buttonText, style: buttonTextStyle ?? Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
          ),
      ),
    );
  }
}




