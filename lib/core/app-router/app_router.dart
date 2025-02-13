import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/app-router/app_router.gr.dart';

//flutter pub run build_runner build --delete-conflicting-outputs
//flutter packages pub run build_runner watch

@LazySingleton()
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: FeaturedFilmListRoute.page, initial: true),
        AutoRoute(
          page: MovieDetailsRoute.page,
        ),
        CustomRoute(
          page: SearchedFilmListRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          // durationInMilliseconds:
        ),
      ];
}
