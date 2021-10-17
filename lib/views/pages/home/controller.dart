import 'package:alga/models/app_location.dart';
import 'package:alga/models/category.dart';
import 'package:alga/product_controller.dart';
import 'package:alga/repositories/app_repo.dart';
import 'package:alga/repositories/category_repo.dart';
import 'package:alga/utils/ad_helper.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePageController extends GetxController {
  final selectedCategoryIndex = 0.obs;
  final selectedLocationId = Rx<int?>(null);
  final openFilter = false.obs;
  final selectedFilterCategoryValue = Rx<dynamic>(null);
  final selectedFilterMetroValue = Rx<dynamic>(null);
  final orderBy = Rx<String?>(null);
  final sortBy = Rx<String?>(null);
  final sortItemValue = 1.obs;
  final priceFrom = Rx<int?>(null);
  final priceTo = Rx<int?>(null);
  final loadingProducts = false.obs;

  final categoryList = <Category>[].obs;
  final locationList = <AppLocation>[].obs;

  BannerAd? get bannerAd => _isAdLoaded.value ? _ad.value : null;

  int _offset = 0;
  bool _hasNext = true;
  bool _filter = false;
  String? _searchText;

  // COMPLETE: Add _kAdIndex
  static final _kAdIndex = 4;
  // COMPLETE: Add a BannerAd instance
  final _ad = Rx<BannerAd?>(null);
  // COMPLETE: Add _isAdLoaded
  final _isAdLoaded = false.obs;

  final _categoryRepo = Get.find<CategoryRepo>();
  final _appRepo = Get.find<AppRepo>();

  @override
  void onInit() {
    fetchProducts();
    fetchCategories();
    fetchLocations();
    _createBannerAd();
    super.onInit();
  }

  fetchProducts() async {
    _filter = false;
    _searchText = null;
    _offset = 0;
    _hasNext = true;
    ProductController.I.clearProducts();
    await _fetchProducts();
  }

  fetchCategoryProducts() async {
    _offset = 0;
    _hasNext = true;
    ProductController.I.clearProducts();
    await _fetchProducts();
  }

  fetchMoreProducts() async {
    await _fetchProducts();
  }

  filterProducts() async {
    _filter = true;
    _offset = 0;
    _hasNext = true;
    ProductController.I.clearProducts();
    await _fetchProducts();
  }

  searchProducts(String text) async {
    _searchText = text.isNotEmpty ? text : null;
    _offset = 0;
    _hasNext = true;
    ProductController.I.clearProducts();
    await _fetchProducts();
  }

  _fetchProducts() async {
    if (!loadingProducts.value && _hasNext) {
      loadingProducts.value = true;

      final categoryID = getSelectedCategory()?.id;
      await ProductController.I.fetchProducts(
        categoryID: categoryID,
        locationID: _filter ? selectedLocationId.value : null,
        offset: _offset,
        orderBy: _filter ? orderBy.value : null,
        sortBy: _filter ? sortBy.value : null,
        priceFrom: _filter ? priceFrom.value : null,
        priceTo: _filter ? priceTo.value : null,
        search: _searchText,
        onSuccess: (data) {
          _hasNext = data.isNotEmpty;
          _offset += 12;
        },
      );

      loadingProducts.value = false;
    }
  }

  _createBannerAd() async {
    try {
      // COMPLETE: Create a BannerAd instance
      _ad.value = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        size: AdSize.banner,
        request: AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            _isAdLoaded.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();

            print(
                'Ad load failed (code=${error.code} message=${error.message})');
          },
        ),
      );
      _ad.value?.load();
    } catch (e) {
      print(e.toString());
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

  Category? getSelectedCategory() {
    return selectedCategoryIndex.value != 0
        ? categoryList[selectedCategoryIndex.value - 1]
        : null;
  }

  @override
  void onClose() {
    super.onClose();
    openFilter.close();
    selectedCategoryIndex.close();
    categoryList.close();
    locationList.close();
    selectedFilterCategoryValue.close();
    _ad.value?.dispose();
    _ad.close();
    _isAdLoaded.close();
  }
}
