import 'dart:async';

import 'package:alga/data/app_routes.dart';
import 'package:alga/utils/app_box.dart';
import 'package:get/get.dart';

class StartPageController extends GetxController {
  bool ready = false;

  @override
  void onInit() {
    Timer(Duration(milliseconds: 4000), () {
      if (AppBox.locale == null) {
        ready = true;
        update();
      } else {
        Get.toNamed(AppRoutes.home);
      }
    });
    super.onInit();
  }
}
