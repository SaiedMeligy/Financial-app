import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../domain/entities/AdviceMode.dart';
import '../../domain/repository/advices/AllAdvices/all_advices_repository.dart';
import '../dataSource/Advices/AllAdvices/all_advices_data_source.dart';

class AllAdvicesRepositoryImp implements AllAdvicesRepository{
  final AllAdvicesDataSource dataSource;
  AllAdvicesRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllAdvices(AdviceModel adviceModel) async {
    try {
      final response = await dataSource.getAllAdvices(
          adviceModel);
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