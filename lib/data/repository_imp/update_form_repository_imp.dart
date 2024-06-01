import 'package:dio/dio.dart';
import '../../core/Failure/server_failure.dart';
import '../../domain/repository/FormRepository/updateForm/update_form_repository.dart';
import '../dataSource/Form/updateForm/update_form_data_source.dart';

class UpdateFormRepositoryImp implements UpdateFormRepository {
  final UpdateFormDataSource dataSource;
  UpdateFormRepositoryImp(this.dataSource);

  @override
  Future<Response> update(Map<String, dynamic> updateRequest) async {
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
