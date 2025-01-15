import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';

import '../../../domain/repository/admin repository/patiens/getSessionDetailsRepository/get_session_details_repository.dart';
import '../../dataSource/admin/Patients/getSessionDetails/get_session_details_data_source.dart';

class GetSessionDetailsRepositoryImp implements GetSessionDetailsRepository{
  final GetSessionDetailsDataSource dataSource;
  GetSessionDetailsRepositoryImp(this.dataSource);
  @override
  Future<Response> getSessionDetails(String nationalId,int? with_all_questions) async {
    try {
      final response = await dataSource.getSessionDetails(
          nationalId,with_all_questions);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          // SnackBarService.showSuccessMessage(response.data["message"]);
          //
          // print("--------->"+response.toString());

          return response;
        }
        else {
           SnackBarService.showErrorMessage(response.data["message"]);
          throw ServerFailure(statusCode: response.statusCode.toString(),
              message: response.data["message"] ?? "unKnown error"
          );
        }
      }
      else{
        // SnackBarService.showErrorMessage(response.data["message"]);

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