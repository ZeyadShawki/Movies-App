// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/helpers/di/dependency_config.dart';
import 'package:movies/core/helpers/extensions/string_extensions.dart';
import 'package:movies/core/network/api_constants.dart';
import 'package:movies/core/theme/animated_fade_widget.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/utils/enum_movie_state.dart';
import 'package:movies/movies/presentation/bloc/movie_details_cubit/movie_details_cubit.dart';
import 'package:movies/movies/presentation/bloc/movie_details_cubit/movie_details_state.dart';
import 'package:movies/movies/presentation/widgets/image_loading_error_widget.dart';
import 'package:movies/movies/presentation/widgets/loading_indicator_widget.dart';

@RoutePage()
class MovieDetailsScreen extends StatelessWidget {
  final int id;
  const MovieDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MovieDetailsCubit>()
        ..getMovieDetails(id)
        ..getRecomended(id),
      child: BlocConsumer<MovieDetailsCubit, MovieDetailsInitial>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.recommendedstate == RequestState.isLoaded) {
            return Scaffold(
                backgroundColor: AppColors.blackPrimary1,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Image(
                            width: double.infinity,
                            height: 250.h,
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              ApiConstants().networkimagemaker(
                                state.movieDetails.backDropPath,
                              ),
                            ),
                            errorBuilder: (context, error, stackTrace) =>
                                SizedBox.shrink(),
                          ),
                          Positioned(
                            left: 20,
                            top: 30,
                            child: AnimatedFadeWidget(
                              onTap: () {
                                context.router.maybePop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 10),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 30.r,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 250.h),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              color: Colors.grey.shade900,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 150, vertical: 10),
                                    child: Divider(
                                      thickness: 3,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child:
                                          state.movieDetails.title.toSubTitle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: state.movieDetails.releaseDate
                                              .split('-')
                                              .first
                                              .toSubTitle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            state.movieDetails.voteAverage
                                                .toString()
                                                .toSubTitle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        '${(state.movieDetails.runtime / 60).floor()}h ${state.movieDetails.runtime - 60 > 120 ? (state.movieDetails.runtime) - 120 : (state.movieDetails.runtime) - 60}m'
                                            .toSubTitle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: 'Storyline'.toSubTitle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 10),
                                    child: state.movieDetails.overview
                                        .toSubTitle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                    child: ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: Colors.grey
                                              .withValues(alpha: 0.1),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Center(
                                            child: state
                                                .movieDetails.genre[index].name
                                                .toSubTitle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          state.movieDetails.genre.length,
                                      separatorBuilder: (context, state) =>
                                          const SizedBox(
                                        width: 10,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0,
                                        right: 15,
                                        top: 20,
                                        bottom: 10),
                                    child: 'More Like This'.toSubTitle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  state.recommendedstate ==
                                          RequestState.isLoaded
                                      ? SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: GridView.builder(
                                            padding: const EdgeInsets.all(15),
                                            physics:
                                                const BouncingScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount:
                                                        MediaQuery.sizeOf(
                                                                        context)
                                                                    .width >
                                                                1000
                                                            ? 4
                                                            : 3,
                                                    // mainAxisExtent: 30,
                                                    childAspectRatio: 1,
                                                    crossAxisSpacing: 1,
                                                    mainAxisSpacing: 20),
                                            itemBuilder: (context, int index) {
                                              int currentindex = index;

                                              return InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MovieDetailsScreen(
                                                                  id: state
                                                                      .recommendedmovieDetails[
                                                                          index]
                                                                      .id)));
                                                },
                                                child: imageGridView(state
                                                    .recommendedmovieDetails[
                                                        currentindex]
                                                    .posterPath),
                                              );
                                            },
                                            itemCount: state
                                                .recommendedmovieDetails.length,
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 500,
                                          child: LoadingIndicatorWidget())
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 100, left: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                fit: BoxFit.fill,
                                height: 200.h,
                                width: 120.w,
                                image: NetworkImage(
                                  ApiConstants().networkimagemaker(
                                      state.movieDetails.posterPath),
                                ),
                                errorBuilder: (context, error, stackTrace) =>
                                    ImageLoadingErrorWidget(),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ));
          } else {
            return Scaffold(
                backgroundColor: AppColors.blackPrimary1,
                body: const Center(                                          child: LoadingIndicatorWidget())
            );
          }
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget imageGridView(String? Imagepath) {
    return Image(
      // fit: BoxFit.fill,
      image: NetworkImage(ApiConstants().networkimagemaker(Imagepath)),
      errorBuilder: (context, error, stackTrace) => ImageLoadingErrorWidget(),
    );
  }
}
