import 'package:alga/models/app_location.dart';
import 'package:alga/models/category.dart';
import 'package:alga/models/currency.dart';
import 'package:alga/models/product.dart';
import 'package:alga/repositories/app_repo.dart';
import 'package:alga/repositories/category_repo.dart';
import 'package:alga/repositories/product_repo.dart';
import 'package:alga/utils/helper.dart';
import 'package:alga/utils/image_manager.dart';
import 'package:alga/utils/notifications_manager.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:multi_image_picker2/multi_image_picker2.dart';

class AddProductPageController extends GetxController {
  final categoryList = <Category>[].obs;
  final locationList = <AppLocation>[].obs;
  final currencyList = <Currency>[].obs;

  final loading = false.obs;
  final status = ProductStatus.USUAL.obs;
  final selectedCategoryId = Rx<int?>(null);
  final selectedLocationId = Rx<int?>(null);
  final selectedCurrencyId = Rx<int?>(null);
  final price = ''.obs;

  final selectedImage = Rx<Asset?>(null);

  final _productRepo = Get.find<ProductRepo>();
  final _categoryRepo = Get.find<CategoryRepo>();
  final _appRepo = Get.find<AppRepo>();

  @override
  void onInit() {
    fetchCategories();
    fetchLocations();
    fetchCurrencies();
    super.onInit();
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

  fetchCurrencies() async {
    final response = await _appRepo.fetchCurrencies();
    if (response.status && response.data != null) {
      currencyList.value = response.data!;
    }
  }

  startFilePicker() async {
    final assets = await ImageManager.pickImages(maxImages: 1);
    if (assets.isNotEmpty) {
      selectedImage.value = assets.first;
    }
  }

  removeImage() {
    selectedImage.value = null;
  }

  save(Map<String, dynamic> data, {onSuccess, onError}) async {
    if (selectedImage.value == null) {
      Get.snackbar('app_title'.tr, 'Выберите изображение');
    } else if (selectedCategoryId.value == null) {
      Get.snackbar('app_title'.tr, 'Выберите категорию');
    } else if (selectedLocationId.value == null) {
      Get.snackbar('app_title'.tr, 'Выберите станцию');
    } else {
      loading.value = true;

      data['price'] = price.value.isNotEmpty ? price.value : null;
      data['status'] = status.value;
      data['category_id'] = selectedCategoryId.value;
      data['location_id'] = selectedLocationId.value;
      data['currency_id'] = price.value.isEmpty
          ? null
          : selectedCurrencyId.value ??
              (currencyList.isNotEmpty ? currencyList.first.id : null);
      final bytes =
          await ImageManager.getBytesFromImageAsset(selectedImage.value!);
      data['image'] =
          MultipartFile.fromBytes(bytes, filename: selectedImage.value!.name);
      data['uuid'] = DateTime.now().millisecondsSinceEpoch;

      final response = await _productRepo.create(data);
      if (response.status) {
        loading.value = false;
        onSuccess?.call();
      } else {
        loading.value = false;
        onError?.call(response.errorData);
      }
    }
  }

  @override
  void onClose() {
    categoryList.close();
    locationList.close();
    currencyList.close();
    selectedCategoryId.close();
    selectedLocationId.close();
    selectedCurrencyId.close();
    selectedImage.close();
    price.close();
    super.onClose();
  }
}
