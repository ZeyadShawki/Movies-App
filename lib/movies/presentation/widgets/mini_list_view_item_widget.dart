import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/app-router/app_router.gr.dart';
import 'package:movies/core/network/api_constants.dart';
import 'package:movies/core/theme/animated_fade_widget.dart';
import 'package:movies/movies/domain/entities/movie.dart';

class MiniItemWidget extends StatelessWidget {
  const MiniItemWidget({super.key, required this.movie});
final Movie movie;
  @override
  Widget build(BuildContext context) {
    return  AnimatedFadeWidget(
        onTap: () {
          context.router.push(MovieDetailsRoute(id: movie.id ?? 0));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image(
            width: 150,
            height: 300,
            fit: BoxFit.fill,
            image: NetworkImage(
              ApiConstants().networkimagemaker(movie.posterPath),
            ),
          ),
        ),
      );
  }
}