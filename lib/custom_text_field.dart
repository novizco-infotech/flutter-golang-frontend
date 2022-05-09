import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String? hintext;
  double horizontalPadding, verticalPadding;
  TextInputType? keyboardType;
  TextInputType? textInputType;
  String? initialValue;
  String? labelText;
  Widget? icon;
  TextInputAction? textInputAction;
  void Function(String)? onFieldSubmitted;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;
  FocusNode? focusNode;
  TextEditingController? controller;
  EdgeInsetsGeometry? contentPadding;
  InputBorder? border;
  void Function()? onTap;
  bool readOnly;
  bool isSuffixIcon;
  Widget? suffixIcon;

  CustomTextField({
    this.labelText,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.textInputType,
    this.initialValue,
    this.hintext,
    this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
    this.onSaved,
    this.keyboardType,
    this.focusNode,
    this.controller,
    this.contentPadding,
    this.border,
    this.icon,
    this.onTap,
    this.readOnly = false,
    this.isSuffixIcon = false,
    this.suffixIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: TextFormField(
          decoration: InputDecoration(
            suffixIcon: isSuffixIcon == true ? suffixIcon : null,
            labelText: labelText,
            hintText: hintext,
            contentPadding: contentPadding,
            border: border,
            icon: icon,
            hintStyle: Theme.of(context).textTheme.titleMedium,
          ),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          initialValue: initialValue,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
          onSaved: onSaved,
          onTap: onTap,
          focusNode: focusNode,
          controller: controller,
          readOnly: readOnly,
          style: Theme.of(context).textTheme.headline6),
    );
  }
}
