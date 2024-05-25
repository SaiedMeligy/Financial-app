import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../domain/repository/advices/addAdvice/add_advice_repository.dart';
import '../dataSource/Advices/addAdvice/add_advice_data_source.dart';

class AddAdviceRepositoryImp implements AddAdviceRepository{
  final AddAdviceDataSource dataSource;
  AddAdviceRepositoryImp(this.dataSource);
  @override
  Future<Response> addAdvice(String advice) async {
    try {
      final response = await dataSource.addAdvice(advice);
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