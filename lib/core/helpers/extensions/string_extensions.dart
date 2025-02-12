// ignore_for_file: prefer_interpolation_to_compose_strings


import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../theme/app_colors.dart';

extension StringExtensions on String {


  Image toAssetImage({double? height, double? width}) => Image.asset(
        this,
        height: height,
        width: width,
      );

  Widget errText() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: toSubTitle(
            textAlign: TextAlign.start,
            color: AppColors.ellired,
            fontSize: 16.sp),
      );

  Widget toSubTitle({
    num fontSize = AppFontSize.subTitle1,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.textColor,
    Color linkColor = AppColors.colorPrimary,
    TextAlign textAlign = TextAlign.start,
    void Function(String)? launchFunction,
    void Function(String)? onTapHashtag,
    void Function(String)? onTapMention,
    TextOverflow overflow = TextOverflow.clip,
    double? letterSpacing,
    int? maxLines,
    String? fontFamily,
    bool underline = false,
    double? lineHeight,
  }) =>
      Text(
        this,
        overflow: overflow,
        maxLines: maxLines,
        textAlign: textAlign,
        style: AppTheme.subTitle1.copyWith(
          decoration: underline ? TextDecoration.underline : null,
          fontSize: fontSize.sp,
          letterSpacing: letterSpacing,
          height: lineHeight,
          // fontSize: fontSize.sp,
          color: color == AppColors.textColor ? AppColors.textColor : color,
          fontWeight: fontWeight,
          fontFamily: fontFamily ?? 'nunito',
        ),
        // linkStyle: TextStyle(
        //   color: linkColor,
        //   height: 0.8,
        //   decoration: TextDecoration.none,
        // ),
      );

}

class AppFontSize {
  static const num headLine8 = 26;
  static const num headLine7 = 28;
  static const num headLine6 = 20;
  static const num headLine5 = 24;
  static const num headLine4 = 34;
  static const num headLine3 = 48;
  static const num headLine2 = 60;
  static const num headLine1 = 96;
  static const num subTitle1 = 16;
  static const num subTitle2 = 14;
  static const num bodyText1 = 16;
  static const num bodyText2 = 14;
  static const num button = 15;
  static const num caption = 12;
  static const num overLine = 10;
}

TextStyle myFontStyle(
    {FontWeight? fontWeight, required double fontSize, double? letterSpacing}) {
  return TextStyle(
      fontWeight: fontWeight,
      fontSize: ScreenUtil().setSp(fontSize),
      letterSpacing: letterSpacing);
}

class AppTheme {
  static TextStyle get headline5 => myFontStyle(
      fontSize: AppFontSize.headLine5.sp, fontWeight: FontWeight.w600);
  static TextStyle get headline6 => myFontStyle(
      fontWeight: FontWeight.w600,
      fontSize: AppFontSize.headLine6.sp,
      letterSpacing: 0.15);
  static TextStyle get headline4 => myFontStyle(
      fontSize: AppFontSize.headLine4.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25);
  static TextStyle get headline3 => myFontStyle(
      fontSize: AppFontSize.headLine3.sp, fontWeight: FontWeight.w400);
  static TextStyle get headline2 => myFontStyle(
      fontSize: AppFontSize.headLine2.sp,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5);
  static TextStyle get headline1 => myFontStyle(
      fontSize: AppFontSize.headLine1.sp,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5);
  static TextStyle get subTitle1 => myFontStyle(
      fontSize: AppFontSize.subTitle1.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15);
  static TextStyle get subTitle2 => myFontStyle(
      fontSize: AppFontSize.subTitle2.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1);
  static TextStyle get bodyText1 => myFontStyle(
      fontSize: AppFontSize.bodyText1.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5);
  static TextStyle get bodyText2 => myFontStyle(
      fontSize: AppFontSize.bodyText2.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25);
  static TextStyle get button => myFontStyle(
      fontSize: AppFontSize.button.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1);
  static TextStyle get caption => myFontStyle(
      fontSize: AppFontSize.caption.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4);
  static TextStyle get overLine => myFontStyle(
      fontSize: AppFontSize.overLine.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5);
}
