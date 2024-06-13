import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/data/dataSource/sessions/addSession/add_session_data_source.dart';
import 'package:experts_app/domain/entities/AddSessionModel.dart';

import '../../domain/repository/sessions/addSession/add_session_repository.dart';


class AddSessionRepositoryImp implements AddSessionRepository{
  final AddSessionDataSource dataSource;
  AddSessionRepositoryImp(this.dataSource);
  @override
  Future<Response> addSession(AddSessionModel data) async {
    try {
      final response = await dataSource.addSession(data);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response;
        }
        else {
          throw ServerFailure(
            message: response.data["message"] ?? "unknown error",
            statusCode: response.data["status"].toString(),);
        }
      }
      else {
        throw ServerFailure(
          message: response.data["message"] ?? "unknown error",
          statusCode: response.data["status"].toString(),);
      }
    } on DioException catch (dioException) {
      throw ServerFailure(
        message: dioException.response?.data["message"]?? "unknown error",
        statusCode: dioException.response?.statusCode.toString()??"",
      );

    }
  }

}