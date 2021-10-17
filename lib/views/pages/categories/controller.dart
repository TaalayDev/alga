import 'package:alga/models/category.dart';
import 'package:alga/repositories/category_repo.dart';
import 'package:get/get.dart';

class CategoriesPageController extends GetxController {
  final isLoading = false.obs;
  final categoryList = <Category>[].obs;

  final _categoryRepo = Get.find<CategoryRepo>();

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  fetchCategories() async {
    isLoading.value = true;

    final response = await _categoryRepo.fetchAll();
    if (response.status && response.data != null) {
      categoryList.value = response.data!;
    }

    isLoading.value = false;
  }

  deleteCategory(
    Category category, {
    Function? onSuccess,
    Function(dynamic data)? onError,
  }) async {
    final response = await _categoryRepo.remove(category.id ?? 0);
    if (response.status) {
      onSuccess?.call();
    } else {
      onError?.call(response.errorData);
    }
  }
}
