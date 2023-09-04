import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';

class FormFieldWidget extends StatelessWidget {
  final bool? enabled;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Widget? icon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final double? width;
  final void Function()? onTap;
  final TextStyle? style;
  final bool? obscureText;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? padding;
  final bool? readOnly;
  const FormFieldWidget(
      {Key? key,
      this.labelText,
      this.labelStyle,
      this.keyboardType,
      this.textInputAction,
      this.inputFormatters,
      this.onSaved,
      this.controller,
      this.onChanged,
      this.icon,
      this.validator,
      this.width,
      this.onTap,
      this.suffixIcon,
      this.style,
      this.obscureText,
      this.prefixIcon,
      this.padding,
      this.readOnly,
      this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      style: style ??
          Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
      textCapitalization: TextCapitalization.words,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: onSaved,
      controller: controller,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      cursorHeight: 25,
      onTap: onTap,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: suffixIcon, prefixIcon: prefixIcon,
        icon: icon,
        labelText: labelText,
        labelStyle: labelStyle ??
            Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black45, fontSize: 14),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.black54, width: 0.7)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.black54, width: 0.7)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.black54, width: 0.7)),
        // border: const OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(4)),
        //     borderSide: BorderSide(color: Colors.transparent, width: 0.7)
        // ),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(color: Colors.black54, width: 0.7)),
        fillColor: Colors.transparent,
        filled: true, isDense: true,
        contentPadding: const EdgeInsets.all(15),
      ),
      cursorColor: kPrimaryColorLight,
      validator: validator,
    );
  }
}
