import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/constants/colors.dart';
class FlushBarHelper{
  BuildContext? c;
  Flushbar? flush;
  FlushBarHelper(this.c);

  showFlushBar(String message, {Color? color, Widget? icon,Color? borderColor, Color? messageColor}){
    flush = Flushbar(
      borderColor: borderColor, borderWidth: 1.5,
      message:  message, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color ?? kPrimaryColor,
      margin: const EdgeInsets.all(15), icon: icon ?? const SizedBox(),
      borderRadius: BorderRadius.circular(5),
      isDismissible: true, messageColor: messageColor,
      duration: const Duration(seconds: 6),
    )..show(c ?? Get.context!);
  }

  showFlushBarWithAction(String message, String action, {Color? color, Function? actionFunction}){
    flush = Flushbar(
      message:  message, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color ?? Colors.blueGrey,
      margin: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(5),
      isDismissible: true,
      duration: const Duration(seconds: 10),
      mainButton: TextButton(
        onPressed: () {
          actionFunction?.call();
          flush?.dismiss(true);
        },
        child: Text(action, style: const TextStyle(color: Colors.amber),
        ),
      ),
    )..show(c ?? Get.context!);
  }
}