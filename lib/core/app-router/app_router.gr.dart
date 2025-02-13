// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:movies/movies/presentation/screens/featured_film_list_page.dart'
    as _i1;
import 'package:movies/movies/presentation/screens/movie_details_screen.dart'
    as _i2;
import 'package:movies/movies/presentation/screens/searched_film_list_page.dart'
    as _i3;

/// generated route for
/// [_i1.FeaturedFilmListPage]
class FeaturedFilmListRoute extends _i4.PageRouteInfo<void> {
  const FeaturedFilmListRoute({List<_i4.PageRouteInfo>? children})
    : super(FeaturedFilmListRoute.name, initialChildren: children);

  static const String name = 'FeaturedFilmListRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.FeaturedFilmListPage();
    },
  );
}

/// generated route for
/// [_i2.MovieDetailsScreen]
class MovieDetailsRoute extends _i4.PageRouteInfo<MovieDetailsRouteArgs> {
  MovieDetailsRoute({
    _i5.Key? key,
    required int id,
    List<_i4.PageRouteInfo>? children,
  }) : super(
         MovieDetailsRoute.name,
         args: MovieDetailsRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'MovieDetailsRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MovieDetailsRouteArgs>();
      return _i2.MovieDetailsScreen(key: args.key, id: args.id);
    },
  );
}

class MovieDetailsRouteArgs {
  const MovieDetailsRouteArgs({this.key, required this.id});

  final _i5.Key? key;

  final int id;

  @override
  String toString() {
    return 'MovieDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i3.SearchedFilmListPage]
class SearchedFilmListRoute extends _i4.PageRouteInfo<void> {
  const SearchedFilmListRoute({List<_i4.PageRouteInfo>? children})
    : super(SearchedFilmListRoute.name, initialChildren: children);

  static const String name = 'SearchedFilmListRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SearchedFilmListPage();
    },
  );
}
