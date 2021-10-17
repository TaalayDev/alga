import 'package:alga/repositories/product_repo.dart';
import 'package:get/get.dart';

import 'models/product.dart';

class ProductController extends GetxController {
  static final I = Get.find<ProductController>();

  var _productList = <Product>[];
  List<Product> get productList => _productList;

  Product? _productDetails;
  Product? get productDetails => _productDetails;
  set productDetails(Product? product) {
    _productDetails = product;
    update();
  }

  final _productRepo = Get.find<ProductRepo>();

  fetchProducts({
    categoryID,
    locationID,
    offset,
    String? orderBy,
    String? sortBy,
    int? priceFrom,
    int? priceTo,
    String? search,
    Function(List<Product> list)? onSuccess,
  }) async {
    final response = await _productRepo.fetchProducts(
      category: categoryID,
      location: locationID,
      offset: offset,
      orderBy: orderBy ?? 'id',
      sortBy: sortBy ?? 'desc',
      priceFrom: priceFrom,
      priceTo: priceTo,
      search: search,
    );
    if (response.status && response.data != null) {
      onSuccess?.call(response.data!);
      productList.addAll(response.data!);
    }
    update();
  }

  clearProducts() {
    _productList = [];
    update();
  }

  updateProductDetailsElement(Product product) {
    final index = productList.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      productList[index] = productList[index].copy(product);
      productDetails = productList[index];
      update();
    }
  }
}
