import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';

import '../../domain/repository/sessions/deleteSession/delete_session_repository.dart';
import '../dataSource/sessions/deleteSession/delete_session_data_source.dart';


class DeleteSessionRepositoryImp implements DeleteSessionRepository {
  final DeleteSessionDataSource dataSource;

  DeleteSessionRepositoryImp(this.dataSource);

  @override
  Future<Response> deleteSession(int id) async {
    try {
      final response = await dataSource.deleteSession(id);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          SnackBarService.showSuccessMessage(response.data["message"]);
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
