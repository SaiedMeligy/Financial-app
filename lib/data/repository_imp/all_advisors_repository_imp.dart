import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/domain/entities/AllAdvisorsModel.dart';

import '../../domain/entities/AdviceMode.dart';
import '../../domain/repository/advisors/AllAdvisor/all_advisor_repository.dart';
import '../dataSource/getAdvisors/all_advisor_data_source.dart';

class AllAdvisorRepositoryImp implements AllAdvisorRepository{
  final AllAdvisorDataSource dataSource;
  AllAdvisorRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllAdvisor(AllAdvisorsModel advisorModel) async {
    try {
      final response = await dataSource.getAllAdvisor(
          advisorModel);
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