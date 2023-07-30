import 'package:flutter/material.dart';

class FontsConstants {
  static const String sourceSerifProBlack = "SourceSerifPro-Black";
  static const String sourceSerifProBlackItalic = "SourceSerifPro-BlackItalic";
  static const String sourceSerifProBold = "SourceSerifPro-Bold";
  static const String sourceSerifProItalic = "SourceSerifPro-Italic";
  static const String sourceSerifProLight = "SourceSerifPro-Light";
  static const String sourceSerifProRegular = "SourceSerifPro-Regular";
  static const String sourceSerifProSemiBold = "SourceSerifPro-SemiBold";
}

class HeadlineBodyOneBaseWidget extends StatelessWidget {
  const HeadlineBodyOneBaseWidget({
    Key? key,
    this.title,
    this.titleColor,
    this.titleTextAlign = TextAlign.left,
    this.maxLine,
    this.fontWeight,
    this.textOverflow,
    this.fontSize,
    this.foreground,
    this.fontFamily,
    this.underline = false,
    this.letterSpacing,
    this.shadows,
  }) : super(key: key);

  final String? title;
  final Color? titleColor;
  final TextAlign? titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;
  final double? fontSize;
  final Paint? foreground;
  final String? fontFamily;
  final bool underline;
  final double? letterSpacing;
  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: foreground == null ? titleColor : null,
            fontSize: fontSize,
            fontFamily: fontFamily ?? FontsConstants.sourceSerifProRegular,
            foreground: titleColor == null ? foreground : null,
            fontWeight: fontWeight,
            decoration: underline ? TextDecoration.underline : null,
            letterSpacing: letterSpacing,
            shadows: shadows,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: textOverflow,
      softWrap: true,
    );
  }
}
