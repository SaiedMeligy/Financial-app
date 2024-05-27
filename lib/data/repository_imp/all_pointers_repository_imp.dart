import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../domain/entities/pointerModel.dart';
import '../../domain/repository/pointer/AllPointers/all_pointers_repository.dart';
import '../dataSource/Pointers/AllPointers/all_advices_data_source.dart';

class AllPointersRepositoryImp implements AllPointersRepository{
  final AllPointersDataSource dataSource;
  AllPointersRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllPointers(PointerModel pointerModel) async {
    try {
      final response = await dataSource.getAllPointers(
          pointerModel);
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