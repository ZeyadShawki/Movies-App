import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ScreenUtilExtension on num {
  num get toSp => ScreenUtil().setSp(this);

  num get toWidth => ScreenUtil().setWidth(this);

  num get toHeight => ScreenUtil().setHeight(this);

  num get toHorizontal => ScreenUtil().setWidth(this);

  num get toVertical => ScreenUtil().setHeight(this);

  SizedBox get toSizedBox => SizedBox(
        height: h,
        width: w,
      );

  SizedBox getKeyboardBottomPadding(
      {required context, double? screenHightLimit}) {
    double size = MediaQuery.of(context).size.height;
    return MediaQuery.of(context).size.height <= (screenHightLimit ?? 700)
        ? SizedBox(
            height: h * size / 1500,
            width: w,
          )
        : SizedBox(
            height: 0,
            width: 0,
          );
  }

  SizedBox get toSizedBoxVertical => SizedBox(height: h);

  SizedBox get toSizedBoxHorizontal => SizedBox(
        width: w,
      );

  Widget toContainer({required num height, required num width, Color? color}) =>
      Container(
        color: color,
        width: width.w,
        height: height.h,
      );
}
