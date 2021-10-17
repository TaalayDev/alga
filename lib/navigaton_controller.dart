import 'package:alga/utils/app_box.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static final I = Get.find<NavigationController>();

  var langValue = AppBox.locale.obs;
  final phone = ''.obs;
}
