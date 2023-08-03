import 'package:chinesequizapp/infrastructure/Constants/font_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class FormInputText extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  bool obscureText;
  String? hintText;
  String? labelText;
  Color? defaultColor;
  Color? focusedColor;
  FormFieldValidator<String>? validator;
  FocusNode? focusNode;
  final bool autofocus;
  ValueChanged<String>? onChanged;
  final bool isDuplicateCheck;
  final bool isDuplicateChecked;
  final VoidCallback? onDuplicatePressed;
  final AutovalidateMode? autovalidateMode;
  ValueChanged<String>? onFieldSubmitted;
  int? maxLines;
  int? minLines;
  bool enable;
  Color? valueFontColor;
  List<TextInputFormatter>? inputFormatters;
  Widget? suffixIcon;
  BoxConstraints? suffixIconConstraints;
  Widget? suffix;
  InputBorder? disabledBorder;
  InputBorder? enabledBorder;
  InputBorder? focusedBorder;
  TextStyle? style;
  TextStyle? hintStyle;
  TextAlign? textAlign;
  int? maxLength;
  String? counterText;
  String? errorText;
  double fontSize;
  bool readOnly;
  Color? fillColor;

  FormInputText({Key? key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.hintText,
    this.labelText,
    this.defaultColor,
    this.focusedColor,
    this.validator,
    this.focusNode,
    this.autofocus = false,
    this.onChanged,
    this.isDuplicateCheck = false,
    this.isDuplicateChecked = false,
    this.onDuplicatePressed,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.enable = true,
    this.valueFontColor,
    this.minLines,
    this.inputFormatters,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.disabledBorder,
    this.enabledBorder,
    this.focusedBorder,
    this.style,
    this.hintStyle,
    this.textAlign,
    this.suffix,
    this.maxLength,
    this.counterText,
    this.errorText,
    this.fontSize = 18,
    this.readOnly = false,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      enabled: enable,
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      focusNode: focusNode,
      autofocus: autofocus,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      maxLength: maxLength,
      decoration: InputDecoration(
        filled: fillColor != null,
        fillColor: fillColor,
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        alignLabelWithHint: true,
        enabledBorder: enabledBorder ?? OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: HexColor('#D2D3D7'),
          ),
        ),
        disabledBorder: disabledBorder ?? OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: HexColor('#D2D3D7'),
          ),
        ),
        focusedBorder: focusedBorder ?? OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: HexColor('#1C1C1C'),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        hintStyle: hintStyle ?? TextStyle(
          fontFamily: FontsConstants.sourceSerifProBold,
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          color: HexColor('#B5B4C0'),
        ),
        labelStyle: TextStyle(
          fontFamily: FontsConstants.sourceSerifProBold,
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          color: HexColor('#B5B4C0'),
        ),
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        suffix: suffix,
        counterText: counterText,
      ),
      style: style ?? TextStyle(
        fontFamily: FontsConstants.sourceSerifProBold,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: HexColor('#1C1C1C'),
      ),
      validator: validator,
      autovalidateMode: autovalidateMode,
      textAlign: textAlign ?? TextAlign.start,
    );
  }

  static InputBorder errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    );
  }
}