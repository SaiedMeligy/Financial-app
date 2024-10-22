import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../../domain/entities/AllSessionModel.dart';
import '../../../domain/repository/admin repository/AllSessionWithAdmin/all_session_with_admin_repository.dart';
import '../../dataSource/admin/AllSessionWithAdmin/all_session_with_admin_data_source.dart';

class AllSessionWithAdminRepositoryImp implements AllSessionWithAdminRepository{
  final AllSessionWithAdminDataSource dataSource;
  AllSessionWithAdminRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllSessionWithAdmin(AllSessionModel sessionModel,{int page =1,int per_page=15}) async {
    try {
      final response = await dataSource.getAllSessionWithAdmin(
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