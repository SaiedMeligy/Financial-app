
import 'package:dio/dio.dart';

import '../../core/Failure/server_failure.dart';
import '../../domain/repository/storeForm/store_form_repository.dart';
import '../dataSource/storeForm/store_form_data_source.dart';

class StoreFormRepositoryImp implements StoreFormRepository{
  final StoreFormDataSource dataSource;
  StoreFormRepositoryImp(this.dataSource);
  @override
  Future<Response> store(Map<String,dynamic> storeRequest) async {
    try {
      final response = await dataSource.store(storeRequest);
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
      throw ServerFailure(
          statusCode: dioException.response?.statusCode.toString()??"",
          message: dioException.response?.data["message"]?? "unKnown error");
    }
  }

}