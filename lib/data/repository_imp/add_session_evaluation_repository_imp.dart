import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/data/dataSource/sessions/addSession/add_session_data_source.dart';
import 'package:experts_app/domain/entities/AddSessionModel.dart';

import '../../domain/repository/sessions/addSession/add_session_repository.dart';
import '../../domain/repository/sessions/addSessionEvaluation/add_session_evaluation _repository.dart';
import '../dataSource/sessions/addSessionEvaluation/add_session_evaluation_data_source.dart';


class AddSessionEvaluationRepositoryImp implements AddSessionEvaluationRepository{
  final AddSessionEvaluationDataSource dataSource;
  AddSessionEvaluationRepositoryImp(this.dataSource);
  @override
  Future<Response> addSessionEvaluation(List<Map<String, String>>?  pointerEvaluation,int? sessionId,int? formId) async {
    try {
      final response = await dataSource.addSessionEvaluation(pointerEvaluation,sessionId,formId);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response;
        }
        else {
          SnackBarService.showSuccessMessage(response.data["message"]);
          throw
          ServerFailure(
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
      SnackBarService.showErrorMessage(dioException.response?.data["message"]);

      throw
      ServerFailure(
        message: dioException.response?.data["message"]?? "unknown error",
        statusCode: dioException.response?.statusCode.toString()??"",
      );

    }
  }

}