import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../domain/repository/advices/deleteAdvice/delete_advice_repository.dart';
import '../dataSource/Advices/deleteAdvice/delete_advice_data_source.dart';

class DeleteAdviceRepositoryImp implements DeleteAdviceRepository {
  final DeleteAdviceDataSource dataSource;

  DeleteAdviceRepositoryImp(this.dataSource);

  @override
  Future<Response> deleteAdvice(int id) async {
    try {
      final response = await dataSource.deleteAdvice(id);
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
