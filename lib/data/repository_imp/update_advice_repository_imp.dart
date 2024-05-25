import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/data/dataSource/Advices/updateAdvice/update_advice_data_source.dart';
import 'package:experts_app/domain/repository/advices/updateAdvice/update_advice_repository.dart';

import '../../core/Failure/server_failure.dart';

class UpdateAdviceRepositoryImp implements UpdateAdviceRepository{
  final UpdateAdviceDataSource dataSource;
  UpdateAdviceRepositoryImp(this.dataSource);
  @override
  Future<Response> updateAdvice(int id, String title) async {
    try {
      final response = await dataSource.updateAdvice(id,title);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response;
        }
        else {
          throw ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data["message"] ?? "Unknown error",
          );
        }
      }
      else {
        throw ServerFailure(
          statusCode: response.statusCode.toString(),
          message: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (dioException) {
      throw ServerFailure(
        statusCode: dioException.response?.statusCode.toString() ?? "",
        message: dioException.response?.data["message"] ?? "Not found",
      );
    }

  }

}