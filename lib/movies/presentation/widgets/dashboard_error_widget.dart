import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/helpers/extensions/string_extensions.dart';
import 'package:movies/core/theme/animated_fade_widget.dart';
import 'package:movies/core/theme/app_colors.dart';

class DashBoardErrorWidget extends StatelessWidget {
  const DashBoardErrorWidget(
      {super.key,
      required this.message,
      required this.fun,
      this.backgroundColor,
      this.height});
  final String message;
  final VoidCallback fun;
  final Color? backgroundColor;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blackPrimary1,
      child: Center(
        child: Container(
          padding: REdgeInsets.only(left: 15, top: 30, bottom: 30, right: 15),
          margin: REdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.blackPrimary1,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: SizedBox(
            height: height ?? 150.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                message.toSubTitle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
                // Spacer(),
                Spacer(),
                AnimatedFadeWidget(
                  onTap: fun,
                  child: Container(
                    width: double.infinity,
                    padding: REdgeInsets.symmetric(vertical: 15),
                    margin: REdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: AppColors.goldenYellow,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                        child: "Retry Again".toSubTitle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppColors.blackPrimary1)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
