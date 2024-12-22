import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';

import '../../domain/repository/admin repository/deleteSessionWithAdmin/delete_session_with_admin_repository.dart';
import '../dataSource/admin/deleteSessionWithAdmin/delete_session_with_admin_data_source.dart';



class DeleteSessionWithAdminRepositoryImp implements DeleteSessionWithAdminRepository {
  final DeleteSessionWithAdminDataSource dataSource;

  DeleteSessionWithAdminRepositoryImp(this.dataSource);

  @override
  Future<Response> deleteSessionWithAdmin(int id) async {
    try {
      final response = await dataSource.deleteSessionWithAdmin(id);
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
