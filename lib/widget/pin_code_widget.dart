import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class PinCodeWidget extends StatelessWidget {
  final void Function(String)? onCompleted;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  final int? length;
  final double? horizontalPadding;
  const PinCodeWidget({Key? key, this.onCompleted, this.controller, this.validator, required this.onChanged, this.length, this.horizontalPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: 8.0, horizontal: horizontalPadding ?? 5),
        child: PinCodeTextField(
          autoDisposeControllers: false,
          controller: controller,
          onCompleted: onCompleted,
          appContext: context,
          pastedTextStyle: const TextStyle(color: Colors.black,),
          length: length ?? 6, errorTextSpace: 20,
          enablePinAutofill: false, obscureText: true,
          blinkWhenObscuring: true,
          autovalidateMode: AutovalidateMode.disabled,
          animationType: AnimationType.fade,
          validator: validator,
          pinTheme: PinTheme(
            fieldHeight: 45, fieldWidth: 45,
            shape: PinCodeFieldShape.underline, errorBorderColor: Colors.transparent,
            selectedColor: Colors.black45, selectedFillColor: Colors.transparent,
            activeColor: Colors.black45, activeFillColor: Colors.transparent,
            inactiveColor: Colors.black45, inactiveFillColor: Colors.transparent,
          ),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          // errorAnimationController: errorController,
          // controller: pinController,
          keyboardType: TextInputType.number,
          onChanged: onChanged,
            // resetPasswordController.otp = value;
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            if(text!.isNotEmpty){
              return true;
            } else {
              return false;
            }
          },
        ));
  }
}
