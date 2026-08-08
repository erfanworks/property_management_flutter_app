import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imusa04_landlord_app/routes/app_routes/app_routes.dart';
import 'package:imusa04_landlord_app/routes/app_routes/app_routes_file.dart';
import 'package:imusa04_landlord_app/widget/AppImage/app_image.dart';
import 'package:imusa04_landlord_app/widget/AppLoader/app_loader.dart';
import 'initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await LocationService.instance.init();
  await init();
  await ScreenUtil.ensureScreenSize();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  HttpOverrides.global = CustomHttpClient();
  PaintingBinding.instance.imageCache.maximumSizeBytes = 200 * 1024 * 1024;
  PaintingBinding.instance.imageCache.maximumSize = 1000;

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          navigatorKey: AppLoader.navigatorKey,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
          getPages: appRouteFile,
          initialRoute: AppRoutes.navBar,
        );
      },
    );
  }
}
