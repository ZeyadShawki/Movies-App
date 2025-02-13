import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/extensions/screen_util_extension.dart';
import '../../../core/helpers/extensions/string_extensions.dart';
import '../../../core/network/api_constants.dart';
import '../../domain/entities/movie.dart';
import '../widgets/image_loading_error_widget.dart';

mixin FilmDetailsViewer<T extends StatefulWidget> on State<T> {
  bool showFilmDetails = false;
  Movie? movie;
  double scale = 0.8; // Start with a smaller scale

  Widget screen(BuildContext context);

  @override
  void initState() {
    super.initState();

    // Trigger the opening animation when the widget initializes
    Future.delayed(const Duration(milliseconds: 10), () {
      if (mounted) {
        setState(() => scale = 1.0);
      }
    });
  }

  void viewFilmDetails({Movie? movie}) {
    setState(() {
      this.movie = movie;
      showFilmDetails = true;
      scale = 0.81; // Reset scale before animation
    });

    // Animate opening after a short delay to ensure the UI updates
    Future.delayed(const Duration(milliseconds: 10), () {
      if (mounted) {
        setState(() => scale = 1.0);
      }
    });
  }

  void hideFilmDetails() {
    setState(() => showFilmDetails = false);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: hideFilmDetails,
            child: screen(context),
          ),
          if (showFilmDetails)
            GestureDetector(
              onTap: hideFilmDetails,
              onTapDown: (_) => setState(() => scale = 0.9), // Shrink on press
              onTapUp: (_) => setState(() => scale = 1.0), // Restore on release
              onTapCancel: () => setState(() => scale = 1.0), // Reset on cancel
              child: AnimatedScale(
                scale: scale,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutBack, // Smooth pop-in effect
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: REdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          60.toSizedBox,
                          Container(
                            height: 350.h,
                            width: 230.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                ApiConstants().networkimagemaker(
                                            movie?.posterPath) ==
                                        'https://image.tmdb.org/t/p/w500null'
                                    ? 'https://img.freepik.com/free-vector/internet-network-warning-404-error-page-file-found-web-page-internet-error-page-issue-found-network-404-error-present-by-man-sleep-display_1150-55450.jpg?w=740&t=st=1663006046~exp=1663006646~hmac=d14191cc254ee49be9fe5a83ede0836c3e8085c67d04be6746f0d1977ce085bb'
                                    : ApiConstants()
                                        .networkimagemaker(movie?.posterPath),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    ImageLoadingErrorWidget(),
                              ),
                            ),
                          ),
                          20.toSizedBox,
                          movie?.title?.toSubTitle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ) ??
                              const SizedBox(),
                          15.toSizedBox,
                          if (movie?.releaseDate != null &&
                              movie!.releaseDate!.split('-').first != '')
                            movie!.releaseDate!.split('-').first.toSubTitle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                          15.toSizedBox,
                          movie?.overview?.toSubTitle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ) ??
                              const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
