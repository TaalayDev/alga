import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'utils/app_bindings.dart';
import 'utils/app_box.dart';
import 'data/app_routes.dart';
import 'data/app_translations.dart';
import 'data/styles.dart';
import 'utils/notifications_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await AppBox.init();
  await Firebase.initializeApp();
  PushNotificationsManager().init();
  MobileAds.instance.initialize();
  // ca-app-pub-3940256099942544/6300978111
  // ca-app-pub-9791514763759921~9258859687

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        title: 'Алга',
        locale: AppBox.locale ?? Locale('ru', 'RU'),
        translations: AppTranslations(),
        initialBinding: AppBindings(),
        getPages: AppRoutes.pages,
        initialRoute: AppRoutes.initialRoute,
        theme: AppTheme.lightTheme.themeData,
        darkTheme: AppTheme.darkTheme.themeData,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
