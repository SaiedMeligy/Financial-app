import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';

import '../../domain/repository/complaint/AddComplaint/add_complaint_repository.dart';
import '../dataSource/complaint/addcomplaint/add_complaint_data_source.dart';


class AddComplaintRepositoryImp implements AddComplaintRepository{
  final AddComplaintDataSource dataSource;
  AddComplaintRepositoryImp(this.dataSource);
  @override
  Future<Response> addComplaint(String complaint,String nationalID) async {
    try {
      final response = await dataSource.addComplaint(complaint,nationalID);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          SnackBarService.showSuccessMessage(response.data["message"]);
          return response;
        }
        else {
          SnackBarService.showErrorMessage(response.data["message"]);
          throw ServerFailure(
            message: response.data["message"] ?? "unknown error",
            statusCode: response.data["status"].toString(),);
        }
      }
      else {
        SnackBarService.showErrorMessage(response.data["message"]);
        throw ServerFailure(
          message: response.data["message"] ?? "unknown error",
          statusCode: response.data["status"].toString(),);
      }
    } on DioException catch (dioException) {
      SnackBarService.showErrorMessage("Network error");
      throw ServerFailure(
        message: dioException.response?.data["message"]?? "unknown error",
        statusCode: dioException.response?.statusCode.toString()??"",
      );

    }
  }

}