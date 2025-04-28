import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';

import '../../core/Failure/server_failure.dart';
import '../../domain/entities/AdvisorProfileModel.dart';
import '../../domain/repository/Profile Repository/update_profile_repository.dart';
import '../dataSource/ProfileAdvisor/updateProfile/update_profile_data_source.dart';

class UpdateProfileRepositoryImp implements UpdateProfileRepository{
  final UpdateProfileDataSource dataSource;
  UpdateProfileRepositoryImp(this.dataSource);
  @override
  Future<Response> updateProfile({required AdvisorModel advisor}) async {
    try {
      final response = await dataSource.updateProfile(advisor: advisor);
      if (response.statusCode == 200) {
        if (response.data["success"] == true) {
          SnackBarService.showSuccessMessage(response.data['message']);
          return response;
        }
        else {
          SnackBarService.showErrorMessage(response.data['message']);

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