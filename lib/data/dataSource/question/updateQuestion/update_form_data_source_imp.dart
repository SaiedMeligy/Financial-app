import 'package:dio/dio.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'update_form_data_source.dart';

class UpdateQuestionDataSourceImp implements UpdateQuestionDataSource{
  final Dio  dio;
  UpdateQuestionDataSourceImp(this.dio);

  @override
  Future<Response> updateQuestion(Map<String, dynamic> requestData) async{
    try {
      return await dio.patch(
        '/api/questions/update-question',
        data: requestData,
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        ),
      );
    } on DioError catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

}