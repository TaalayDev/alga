import 'package:alga/models/settings.dart';
import 'package:alga/repositories/app_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AboutAppPageController extends GetxController {
  AppSettings? settings;
  var isLoading = false;

  final textController = TextEditingController();

  final _appRepo = Get.find<AppRepo>();

  @override
  void onInit() {
    super.onInit();
    fetchSettings();
  }

  fetchSettings() async {
    isLoading = true;
    update();

    final response = await _appRepo.fetchSettings();
    if (response.status && response.data != null) {
      settings = response.data;
      textController.text = settings?.appShortDescription ?? '';
    }

    isLoading = false;
    update();
  }

  updateAppDescription() async {
    if (textController.text.isEmpty) {
      Get.snackbar('app_title'.tr, 'Введите текст');
      return;
    }

    isLoading = true;
    update();

    final response = await _appRepo.updateSettings({
      'app_short_description': textController.text,
    });
    if (response.status && response.data != null) {
      settings = response.data;
      textController.text = settings?.appShortDescription ?? '';
      Get.snackbar('app_title'.tr, 'Успешно сохранено');
    }

    isLoading = false;
    update();
  }
}
