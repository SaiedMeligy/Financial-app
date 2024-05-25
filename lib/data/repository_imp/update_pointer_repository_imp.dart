import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import '../../core/Failure/server_failure.dart';
import '../../domain/repository/pointer/updatePointer/update_pointer_repository.dart';
import '../dataSource/Pointers/updatePointer/update_pointer_data_source.dart';

class UpdatePointerRepositoryImp implements UpdatePointerRepository{
  final UpdatePointerDataSource dataSource;
  UpdatePointerRepositoryImp(this.dataSource);
  @override
  Future<Response> updatePointer(int id, String title) async {
    try {
      final response = await dataSource.updatePointer(id,title);
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