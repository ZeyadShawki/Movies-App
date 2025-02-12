import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/app-router/app_router.dart';
import 'package:movies/core/helpers/di/dependency_config.dart';

void main() async{
    await dotenv.load();

    await configureDependencies();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final appRouter = getIt<AppRouter>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (_, __) {
        return MaterialApp.router(
          supportedLocales: const [Locale("en")],
          title: 'Movies App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            fontFamily: 'nunito',
            primarySwatch: Colors.blue,
            useMaterial3: false,
            textTheme: const TextTheme(bodySmall: TextStyle()).apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
          ),
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
    
        // home: TestDummyScreen(),
      );
    },
        
        );
          
  }
}
