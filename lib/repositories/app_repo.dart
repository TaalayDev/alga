import 'package:alga/models/app_location.dart';
import 'package:alga/models/currency.dart';
import 'package:alga/models/response_model.dart';
import 'package:alga/models/settings.dart';
import 'package:alga/repositories/base_repo.dart';
import 'package:dio/dio.dart';

class AppRepo extends BaseRepo {
  Future<ResponseModel<List<AppLocation>>> fetchLocations() async {
    var responseModel = ResponseModel<List<AppLocation>>();
    try {
      final response = await get('locations');
      if (isOk(response)) {
        responseModel = ResponseModel.fromMap(response.data);
        responseModel.data = AppLocation.fromList(response.data['data']);
      }
    } on DioError catch (e) {
      responseModel.errorData = e.response?.data;
    }
    return responseModel;
  }

  Future<ResponseModel<List<Currency>>> fetchCurrencies() async {
    var responseModel = ResponseModel<List<Currency>>();
    try {
      final response = await get('currencies');
      if (isOk(response)) {
        responseModel = ResponseModel.fromMap(response.data);
        responseModel.data = Currency.fromList(response.data['data']);
      }
    } on DioError catch (e) {
      responseModel.errorData = e.response?.data;
    }
    return responseModel;
  }

  Future<ResponseModel<AppSettings>> fetchSettings() async {
    var responseModel = ResponseModel<AppSettings>();
    try {
      final response = await get('settings');
      if (isOk(response)) {
        responseModel = ResponseModel.fromMap(response.data);
        responseModel.data = AppSettings.frommap(response.data['data']);
      }
    } on DioError catch (e) {
      responseModel.errorData = e.response?.data;
    }
    return responseModel;
  }

  Future<ResponseModel<AppSettings>> updateSettings(
      Map<String, dynamic> data) async {
    var responseModel = ResponseModel<AppSettings>();
    try {
      final response = await post('settings/update', data: data);
      if (isOk(response)) {
        responseModel = ResponseModel.fromMap(response.data);
        responseModel.data = AppSettings.frommap(response.data['data']);
      }
    } on DioError catch (e) {
      responseModel.errorData = e.response?.data;
    }
    return responseModel;
  }

  Future<bool> login(String login, String password) async {
    try {
      final response = await post('login', data: {
        'email': login,
        'password': password,
      });

      return isOk(response);
    } on DioError catch (e) {
      return false;
    }
  }
}
