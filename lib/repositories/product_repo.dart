import 'package:alga/models/product.dart';
import 'package:alga/models/response_model.dart';
import 'package:alga/repositories/base_repo.dart';
import 'package:dio/dio.dart';

class ProductRepo extends BaseRepo {
  Future<ResponseModel<List<Product>>> fetchProducts({
    int limit = 12,
    int offset = 0,
    int? category,
    int? location,
    String orderBy = 'id',
    String sortBy = 'desc',
    int? priceFrom,
    int? priceTo,
    String? search,
  }) async {
    var responseModel = ResponseModel<List<Product>>();

    try {
      final params = <String, dynamic>{
        'limit': limit,
        'offset': offset,
        'orderBy': 'status;$orderBy',
        'sortedBy': sortBy,
      };
      if (category != null && category != 0) params['category'] = category;
      if (location != null && location != 0) params['location'] = location;
      if (priceFrom != null && priceTo != null) {
        params['price_from'] = priceFrom;
        params['price_to'] = priceTo;
      }
      if (search != null) params['search'] = search;
      params['with'] = 'category;currency;location;media';
      final response = await get('products', params: params);
      if (isOk(response)) {
        responseModel = ResponseModel.fromMap(response.data);
        responseModel.data = Product.fromList(response.data['data']);
      }
    } on DioError catch (e) {
      responseModel.errorData = e.response?.data;
    }

    return responseModel;
  }

  Future<ResponseModel<Product>> create(Map<String, dynamic> data) async {
    var responseModel = ResponseModel<Product>();
    try {
      final response = await post('products', data: FormData.fromMap(data));
      if (isOk(response)) {
        responseModel = ResponseModel.fromMap(response.data);
        // responseModel.data = Product.fromMap(response.data['data']);
      }
    } on DioError catch (e) {
      responseModel.errorData = e.response?.data;
    }
    return responseModel;
  }

  Future<ResponseModel<Product>> update(
      int productId, Map<String, dynamic> data) async {
    var responseModel = ResponseModel<Product>();
    try {
      final response = await put('products/$productId', data: data);
      if (isOk(response)) {
        print('update product ${response.data}');
        responseModel = ResponseModel.fromMap(response.data);
        responseModel.data = Product.fromMap(response.data['data']);
      }
    } on DioError catch (e) {
      responseModel.errorData = e.response?.data;
    }
    return responseModel;
  }
}
