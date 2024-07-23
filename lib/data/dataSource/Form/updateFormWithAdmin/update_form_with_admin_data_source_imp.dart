import 'package:dio/dio.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'update_form_with_Admin_data_source.dart';

class UpdateFormWithAdminDataSourceImp implements UpdateFormWithAdminDataSource{
  final Dio dio;
  UpdateFormWithAdminDataSourceImp(this.dio);

  @override
  Future<Response> update(Map<String, dynamic> updateData) async {
    try {
      final response = await dio.post(
        '/api/update-form',
        data: updateData,
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