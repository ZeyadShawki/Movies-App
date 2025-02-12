import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/asset_manger/app_string.dart';
import 'package:movies/core/asset_manger/asset_manger.dart';
import 'package:movies/core/helpers/extensions/screen_util_extension.dart';
import 'package:movies/core/helpers/extensions/string_extensions.dart';
import 'package:movies/core/theme/app_colors.dart';

@RoutePage()
class FeaturedFilmListPage extends StatelessWidget {
  const FeaturedFilmListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackPrimary1,
      body: SafeArea(
        child: Column(
          children: [
            70.toSizedBox,
            AppStrings.featuredFilms
                .toSubTitle(fontSize: 24, fontWeight: FontWeight.w600),
            40.toSizedBox,
            Container(
              height: 350.h,
              width: 230.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  'https://dummyimage.com/466x310/000/fff',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            20.toSizedBox,
            AppStrings.featuredFilms
                .toSubTitle(fontSize: 18, fontWeight: FontWeight.w600),
            10.toSizedBox,
            AppStrings.featuredFilms.toSubTitle(
                fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w300),
            60.toSizedBox,
            Container(
              decoration: BoxDecoration(
                  color: AppColors.blackPrimary2,
                  borderRadius: BorderRadius.circular(30)),
              padding: REdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetManger.iconsPath,
                    colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  'Search'.toSubTitle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
