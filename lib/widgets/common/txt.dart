import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';



class MyText extends StatelessWidget {
  final Function(String value)? onChanged;
  String? Function(String? value)? validator;
  bool isPasswordField;
  bool isEnabled;
  bool readOnly;
  String hintText;
  String initialValue;
  double width;
  double borderRadius;
  double height;
  int maxLength;
  int maxLine;
  TextStyle? textStyle;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextEditingController? controller;
  TextInputType? keyboardType;
  void Function()? onSuffixItemTapped;
  void Function()? onPrefixItemTapped;
  EdgeInsetsGeometry? contentPadding;
  bool isNaira;
  bool alignCenter;

  MyText({
    this.validator,
    this.isPasswordField = false,
    this.isEnabled = true,
    this.hintText = "",
    this.initialValue = '',
    this.width = double.infinity,
    this.borderRadius = 10,
    this.height = 20,
    this.textStyle,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.maxLength = 80,
    this.maxLine = 1,
    this.onSuffixItemTapped,
    this.onPrefixItemTapped,
    this.keyboardType,
    this.controller,
    this.contentPadding,
     this.onChanged,
    this.isNaira = false,
    this.alignCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    bool usesSuffixIcon = (suffixIcon != null);
    bool usesPrefixIcon = (prefixIcon != null);
    return Container(
      width:  width,
      child: TextFormField(
        enabled: isEnabled,
        onChanged: onChanged,
        controller: controller,
        obscureText: isPasswordField,
        maxLines: maxLine,
        readOnly: readOnly,
        maxLength: maxLength,
        validator: validator,
        keyboardType: isNaira && keyboardType == null
            ? TextInputType.number
            : keyboardType,
        inputFormatters: (keyboardType == TextInputType.number)
            ? [
          new FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
        ]
            : null,
        textAlign: alignCenter?TextAlign.center:TextAlign.left,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),
          counterText: "",

         border: InputBorder.none,
          filled: true,
          fillColor: Color(0xFFF2F4F7),
          prefixIcon:  usesPrefixIcon
              ? InkWell(
            onTap: onPrefixItemTapped,
            enableFeedback: true,
            child: prefixIcon,
          ): null,

          suffixIcon: usesSuffixIcon
              ? InkWell(
            onTap: onSuffixItemTapped,
            enableFeedback: true,
            child: suffixIcon,
          )
              : null,
          contentPadding: (contentPadding == null)
              ? EdgeInsets.symmetric(vertical: 3, horizontal: 10)
              : contentPadding,
        ),
        style: textStyle,
      ),
    );
  }
}

