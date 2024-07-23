import 'package:dio/dio.dart';

import '../../../../core/Failure/server_failure.dart';
import '../../../../domain/repository/admin repository/form/updateFormWithAdmin/update_form_with_admin_repository.dart';
import '../../../dataSource/Form/updateFormWithAdmin/update_form_with_Admin_data_source.dart';

class UpdateFormWithAdminRepositoryImp implements UpdateFormWithAdminRepository {
  final UpdateFormWithAdminDataSource dataSource;
  UpdateFormWithAdminRepositoryImp(this.dataSource);

  @override
  Future<Response> updateWithAdmin(Map<String, dynamic> updateRequest) async {
    try {
      print('Update Request: $updateRequest');
      final response = await dataSource.update(updateRequest);
      print('Response Status: ${response.statusCode}');
      print('Response Data: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response;
        } else {
          throw ServerFailure(
              statusCode: response.statusCode.toString(),
              message: response.data["message"] ?? "Unknown error"
          );
        }
      } else {
        throw ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data["message"] ?? "Unknown error"
        );
      }
    } on DioException catch (dioException) {
      throw ServerFailure(
          statusCode: dioException.response?.statusCode.toString() ?? "",
          message: dioException.response?.data["message"] ?? "Unknown error"
      );
    }
  }
}
