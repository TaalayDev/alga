import 'package:alga/models/category.dart';
import 'package:alga/repositories/category_repo.dart';
import 'package:get/get.dart';

class AddCategoryPageController extends GetxController {
  final _loading = false.obs;
  final _categoryRepo = Get.find<CategoryRepo>();

  bool get isLoading => _loading.value;

  save(
    String titleRU,
    String titleKG, {
    Function(Category? data)? onSuccess,
    Function(dynamic data)? onError,
  }) async {
    if (titleRU.isEmpty) {
      Get.snackbar('app_title'.tr, 'Введите название РУ');
    } else if (titleKG.isEmpty) {
      Get.snackbar('app_title'.tr, 'Введите название КГ');
    } else {
      _loading.value = true;
      final response = await _categoryRepo
          .create({'title_kg': titleKG, 'title_ru': titleRU});
      if (response.status) {
        onSuccess?.call(response.data);
      } else {
        onError?.call(response.errorData);
      }
      _loading.value = false;
    }
  }

  @override
  void onClose() {
    _loading.close();
    super.onClose();
  }
}
