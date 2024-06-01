import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'store_form_data_source.dart';

class StoreFormDataSourceImp implements StoreFormDataSource{
  final Dio dio;
  StoreFormDataSourceImp(this.dio);

  @override
  Future<Response> store(Map<String, dynamic> storeData) async {
    try {
      print('Request Data: $storeData');
      final response = await dio.post(
        '/api/advicor/form',
        data: storeData,
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        ),
      );
      print('Response Data: ${response.data}');
      return response;
    } on DioError catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }
}
