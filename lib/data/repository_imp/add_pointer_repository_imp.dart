import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../domain/repository/pointer/addPointer/add_pointer_repository.dart';
import '../dataSource/Pointers/addPointer/add_pointer_data_source.dart';

class AddPointerRepositoryImp implements AddPointerRepository{
  final AddPointerDataSource dataSource;
  AddPointerRepositoryImp(this.dataSource);
  @override
  Future<Response> addPointer(int senarioId,String title) async {
    try {
      final response = await dataSource.addPointer(senarioId, title);
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