import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/app-router/app_router.gr.dart';
import '../../../core/asset_manger/app_string.dart';
import '../../../core/asset_manger/asset_manger.dart';
import '../../../core/helpers/di/dependency_config.dart';
import '../../../core/helpers/extensions/screen_util_extension.dart';
import '../../../core/helpers/extensions/string_extensions.dart';
import '../../../core/theme/animated_fade_widget.dart';
import '../../../core/theme/app_colors.dart';
import '../bloc/movie_bloc/bloc.dart';
import '../bloc/movie_bloc/bloc_event.dart';
import '../bloc/movie_bloc/bloc_state.dart';
import '../widgets/get_now_playing_banner_widget.dart';
import '../widgets/get_popular_widget.dart';
import '../widgets/get_top_rated_widget.dart';

@RoutePage()
class FeaturedFilmListPage extends StatelessWidget {
  const FeaturedFilmListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (context) {
        return getIt<MovieBloc>()
          ..add(GetNowPlayingEvent())
          ..add(GetPopularEvent())
          ..add(GetTopRatedEvent());
      },
      child: BlocConsumer<MovieBloc, MovieState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.blackPrimary1,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  70.toSizedBox,
                  AppStrings.featuredFilms
                      .toSubTitle(fontSize: 24, fontWeight: FontWeight.w600),
                  40.toSizedBox,

                  //banner
                  const BannerWidget(),

                  10.toSizedBox,
                  AnimatedFadeWidget(
                    onTap: () {
                      context.router.push(SearchedFilmListRoute());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.blackPrimary2,
                          borderRadius: BorderRadius.circular(30)),
                      padding:
                          REdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AssetManger.searchIcon,
                            colorFilter:
                                ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                          ),
                          10.toSizedBoxHorizontal,
                          AppStrings.search.toSubTitle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey)
                        ],
                      ),
                    ),
                  ),

                  // popular see more
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () => context
                                .read<MovieBloc>()
                                .add(GetNowPlayingEvent()),
                            child: AppStrings.popular.toSubTitle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                        Row(
                          children: [
                            AppStrings.seeMore.toSubTitle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.white,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  // popluer  list view
                  const GetPopularListViewWidget(),
                  // toprated see more

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppStrings.topRated.toSubTitle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        Row(
                          children: const [
                            Text(
                              AppStrings.seeMore,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.white,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  // toprated  list view

                  const GetTopRatedListViewWidget(),

                  50.toSizedBox,
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
