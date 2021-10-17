import 'package:alga/models/category.dart';
import 'package:alga/models/response_model.dart';
import 'package:alga/repositories/base_repo.dart';
import 'package:dio/dio.dart';

class CategoryRepo extends BaseRepo {
  Future<ResponseModel<List<Category>>> fetchAll() async {
    var responseModel = ResponseModel<List<Category>>();

    try {
      final response = await get('categories');
      if (isOk(response)) {
        responseModel = ResponseModel.fromMap(response.data);
        responseModel.data = Category.fromList(response.data['data']);
      }
    } on DioError catch (e) {
      responseModel.errorData = e.response?.data;
    }

    return responseModel;
  }

  Future<ResponseModel<Category>> create(Map data) async {
    var responseModel = ResponseModel<Category>();
    try {
      final response = await post('categories', data: data);
      if (isOk(response)) {
        responseModel = ResponseModel.fromMap(response.data);
        responseModel.data = Category.fromMap(response.data['data']);
      }
    } on DioError catch (e) {
      responseModel.errorData = e.response?.data;
    }
    return responseModel;
  }

  Future<ResponseModel> remove(int id) async {
    var responseModel = ResponseModel();
    try {
      final response = await delete('categories/$id');
      if (isOk(response)) {
        responseModel = ResponseModel.fromMap(response.data);
      }
    } on DioError catch (e) {
      responseModel.data = e.response?.data;
    }
    return responseModel;
  }
}
