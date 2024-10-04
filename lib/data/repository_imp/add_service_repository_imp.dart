import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../domain/repository/AddService/add_service_repository.dart';
import '../dataSource/AddService/add_service_data_source.dart';

class AddServiceRepositoryImp implements AddServiceRepository {
  final AddServiceDataSource dataSource;

  AddServiceRepositoryImp(this.dataSource);

  @override
  Future<Response> addService(description) async {
    try {
      final response = await dataSource.addService(description);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response;
        } else {
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
      if (dioException.response?.statusCode == 404) {
        throw ServerFailure(
          statusCode: dioException.response?.statusCode.toString() ?? "",
          message: dioException.response?.data["message"] ?? "Not found",
        );
      } else {
        throw ServerFailure(
          statusCode: dioException.response?.statusCode.toString() ?? "",
          message: dioException.response?.data["message"] ?? "Unexpected error",
        );
      }
    }
  }
}
