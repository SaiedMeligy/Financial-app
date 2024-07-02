import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/domain/entities/SessionUpdateModel.dart';

import '../../../domain/repository/sessions/updateSessionWithAdmin/update_session_with_Admin_repository.dart';
import '../../dataSource/sessions/updateSessionWithAdmin/update_session_with_admin_data_source.dart';

class UpdateSessionWithAdminRepositoryImp implements UpdateSessionWithAdminRepository {
  final UpdateSessionWithAdminDataSource dataSource;
  UpdateSessionWithAdminRepositoryImp(this.dataSource);

  @override
  Future<Response> updateSession(SessionsUpdateModel data) async {
    try {
      final response = await dataSource.updateSession(data);

      if (response.statusCode == 200) {

        return response;
      } else {
        throw ServerFailure(
          message: 'Failed to update session: HTTP ${response.statusCode}',
          statusCode: response.statusCode.toString(),
        );
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        final errorMessage = dioError.response?.data["message"] ?? "unknown error";
        throw ServerFailure(
          message: errorMessage,
          statusCode: dioError.response?.statusCode.toString() ?? "",
        );
      } else {
        throw ServerFailure(
          message: 'Failed to update session: ${dioError.message}',
          statusCode: '',
        );
      }
    }
  }
}
