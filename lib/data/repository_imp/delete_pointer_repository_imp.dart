import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../domain/repository/pointer/deletePointer/delete_pointer_repository.dart';
import '../dataSource/Pointers/deletePointer/delete_pointer_data_source.dart';

class DeletePointerRepositoryImp implements DeletePointerRepository {
  final DeletePointerDataSource dataSource;

  DeletePointerRepositoryImp(this.dataSource);

  @override
  Future<Response> deletePointer(int id) async {
    try {
      final response = await dataSource.deletePointer(id);
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
