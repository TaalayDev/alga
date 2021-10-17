import 'package:alga/models/app_location.dart';
import 'package:alga/models/category.dart';
import 'package:alga/models/product.dart';
import 'package:alga/product_controller.dart';
import 'package:alga/repositories/app_repo.dart';
import 'package:alga/repositories/category_repo.dart';
import 'package:alga/repositories/product_repo.dart';
import 'package:alga/utils/app_box.dart';
import 'package:get/get.dart';

class ProductDetailsPageController extends GetxController {
  final categoryList = <Category>[].obs;
  final locationList = <AppLocation>[].obs;

  final selectedCategoryId = Rx<int?>(null);
  final selectedLocationId = Rx<int?>(null);
  final phone = Rx<String?>(null);
  final whatsapp = Rx<String?>(null);
  final status = ProductStatus.USUAL.obs;
  final loading = false.obs;

  final _productRepo = Get.find<ProductRepo>();
  final _categoryRepo = Get.find<CategoryRepo>();
  final _appRepo = Get.find<AppRepo>();

  @override
  void onInit() {
    _initializeValues();
    super.onInit();
  }

  _initializeValues() async {
    if (AppBox.isLogin && ProductController.I.productDetails != null) {
      final product = ProductController.I.productDetails!;
      phone.value = product.phone;
      whatsapp.value = product.whatsapp;
      status.value = product.status ?? ProductStatus.USUAL;

      await fetchCategories();
      await fetchLocations();
      selectedCategoryId.value = product.categoryId;
      selectedLocationId.value = product.locationId;
    }
  }

  fetchCategories() async {
    final response = await _categoryRepo.fetchAll();
    if (response.status && response.data != null) {
      categoryList.value = response.data!;
    }
  }

  fetchLocations() async {
    final response = await _appRepo.fetchLocations();
    if (response.status && response.data != null) {
      locationList.value = response.data!;
    }
  }

  save({
    Function? onSuccess,
    Function(dynamic e)? onError,
  }) async {
    loading.value = true;
    final data = <String, dynamic>{
      'category_id': selectedCategoryId.value,
      'location_id': selectedLocationId.value,
      'phone': phone.value,
      'whatsapp': whatsapp.value,
      'status': status.value,
      'currency_id': ProductController.I.productDetails?.currencyId,
    };
    final response = await _productRepo.update(
        ProductController.I.productDetails?.id ?? 0, data);
    if (response.status) {
      loading.value = false;
      if (response.data != null)
        ProductController.I.updateProductDetailsElement(response.data!);
      onSuccess?.call();
    } else {
      loading.value = false;
      onError?.call(response.errorData);
    }
  }

  @override
  void onClose() {
    categoryList.close();
    locationList.close();
    super.onClose();
  }
}
