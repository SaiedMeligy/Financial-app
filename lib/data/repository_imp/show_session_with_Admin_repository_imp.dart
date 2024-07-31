
import 'package:dio/dio.dart';

import '../../core/Failure/server_failure.dart';
import '../../core/Services/snack_bar_service.dart';
import '../../domain/repository/sessions/showSession/show_session_repository.dart';
import '../../domain/repository/sessions/showSessionWithAdmin/show_session_with_Admin_repository.dart';
import '../dataSource/sessions/showSession/show_session_data_source.dart';
import '../dataSource/sessions/showSessionWithAdmin/show_session_with_admindata_source.dart';

class ShowSessionWithAdminRepositoryImp implements ShowSessionWithAdminRepository{
  final ShowSessionWithAdminDataSource dataSource;
  ShowSessionWithAdminRepositoryImp(this.dataSource);
  @override
  Future<Response> showSession(int id) async {
    try {
      final response = await dataSource.showSession(
          id);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {

          print("--------->"+response.toString());

          return response;
        }
        else {
          throw ServerFailure(statusCode: response.statusCode.toString(),
              message: response.data["message"] ?? "unKnown error"
          );
        }
      }
      else{
        SnackBarService.showErrorMessage(response.data["message"]);

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