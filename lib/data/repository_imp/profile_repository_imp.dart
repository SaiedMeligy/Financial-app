import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import '../../domain/repository/Profile Repository/profile_repository.dart';
import '../../domain/repository/advisors/AllAdvisor/all_advisor_repository.dart';
import '../dataSource/ProfileAdvisor/profile_data_source.dart';
import '../dataSource/getAdvisors/all_advisor_data_source.dart';

class ProfileRepositoryImp implements ProfileRepository{
  final ProfileDataSource dataSource;
  ProfileRepositoryImp(this.dataSource);
  @override
  Future<Response> getProfile(int advisorId) async {
    try {
      final response = await dataSource.getProfileAdvisor(advisorId);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {

          return response;
        }
        else {
          throw ServerFailure(statusCode: response.statusCode.toString(),
              message: response.data["message"] ?? "unKnown error"
          );
        }
      }
      else{
        throw ServerFailure(statusCode: response.statusCode.toString(),
            message: response.data["message"] ?? "unKnown error"
        );
      }
    }on DioException catch (dioException){
      throw ServerFailure(statusCode: dioException.response?.statusCode.toString()??"",
      message: dioException.response?.data["message"]?? "unKnown error");
    }
  }

}