import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/app-router/app_router.gr.dart';
import 'package:movies/core/theme/animated_fade_widget.dart';
import 'package:movies/movies/presentation/widgets/dashboard_error_widget.dart';

import '../../../core/asset_manger/app_string.dart';
import '../../../core/helpers/extensions/screen_util_extension.dart';
import '../../../core/helpers/extensions/string_extensions.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/utils/enum_movie_state.dart';
import '../bloc/movie_bloc/home_moive_bloc.dart';
import '../bloc/movie_bloc/home_moive_bloc_event.dart';
import '../bloc/movie_bloc/home_moive_bloc_state.dart';
import 'image_loading_error_widget.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeMovieBloc, HomeMovieState>(
        buildWhen: (previous, current) =>
            previous.nowPlayingState != current.nowPlayingState,
        listener: (context, state) {},
        builder: (context, state) {
          if (state.nowPlayingState == RequestState.isLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeMovieBloc>().add(GetNowPlayingEvent());
              },
              child: CarouselSlider.builder(
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Column(children: [
                    AnimatedFadeWidget(
                      onTap: () {
                        context.router.push(MovieDetailsRoute(
                            id: state.nowPlayingMovie[index].id ?? 0));
                      },
                      child: Container(
                        height: 350.h,
                        width: 230.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(
                            ApiConstants().networkimagemaker(
                                state.nowPlayingMovie[index].posterPath),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                ImageLoadingErrorWidget(),
                          ),
                        ),
                      ),
                    ),
                    10.toSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 20,
                        ),
                        10.toSizedBox,
                        AppStrings.nowPlaying.toSubTitle(
                            maxLines: 2,
                            lineHeight: 1.5,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    state.nowPlayingMovie[index].title.toString().toSubTitle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                    10.toSizedBox,
                    SizedBox(
                      width: 200.w,
                      // height: 60.h,
                      child: Row(
                        children: [
                          Flexible(
                            child: state.nowPlayingMovie[index].overview
                                .toString()
                                .toSubTitle(
                                    maxLines: 2,
                                    lineHeight: 1.5,
                                    color: Colors.grey,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ]);
                },
                options: CarouselOptions(
                  enlargeCenterPage: true,

                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,

                  viewportFraction: .7, //
                  scrollDirection: Axis.horizontal,
                  height: MediaQuery.of(context).size.height * 0.6,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                ),
                itemCount: state.nowPlayingMovie.length,
              ),
            );
          } else if (state.nowPlayingState == RequestState.isLoading) {
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: const Center(child: CircularProgressIndicator()));
          } else {
            return DashBoardErrorWidget(
              message: state.nowPlayingMessage,
              fun: () {
                context.read<HomeMovieBloc>().add(GetNowPlayingEvent());
              },
            );
          }
        });
  }
}
