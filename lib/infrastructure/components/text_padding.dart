import 'package:chinesequizapp/infrastructure/Constants/font_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class TextPadding extends StatelessWidget {
  final double top;
  final double right;
  final double bottom;
  final double left;
  final String textContent;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;
  final TextDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? letterSpacing;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;
  final double? decorationThickness;

  TextPadding(this.textContent, {Key? key,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
    this.left = 0,
    this.fontFamily,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.overflow,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.decoration,
    this.padding,
    this.height,
    this.letterSpacing,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
      ),
      child: Text(
        textContent ?? '',
        softWrap: softWrap,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: TextStyle(
          fontFamily: fontFamily ?? FontsConstants.sourceSerifProBold,
          fontWeight: fontWeight ?? FontWeight.w500,
          fontSize: fontSize ?? 16,
          color: color ?? HexColor('#1C1C1C'),
          decoration: decoration,
          height: height,
          letterSpacing: letterSpacing,
          decorationStyle: decorationStyle,
          decorationColor: decorationColor,
          decorationThickness: decorationThickness,
        ),
      ),
    );
  }
}