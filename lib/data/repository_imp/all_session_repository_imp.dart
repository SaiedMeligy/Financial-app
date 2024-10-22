import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import '../../domain/entities/AllSessionModel.dart';
import '../../domain/repository/AllSession/all_session_repository.dart';
import '../dataSource/AllSession/all_session_data_source.dart';

class AllSessionRepositoryImp implements AllSessionRepository{
  final AllSessionDataSource dataSource;
  AllSessionRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllSession(AllSessionModel sessionModel,{int page=1,int per_page=15}) async {
    try {
      final response = await dataSource.getAllSession(
          sessionModel,page: page,per_page: per_page);
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