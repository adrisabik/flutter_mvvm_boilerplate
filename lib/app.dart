import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/core/router/app_router.dart';
import 'package:flutter_mvvm_boilerplate/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Root application widget with theme and router configuration.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'MVVM Boilerplate',
          debugShowCheckedModeBanner: false,
          // Theme configuration
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          // Router configuration
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
