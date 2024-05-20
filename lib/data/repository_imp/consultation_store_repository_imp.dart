import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../domain/repository/ConsultationServices/ConsultationStore/consultation_store_repository.dart';
import '../dataSource/ConsultationServices/ConsultationStore/Consultation_Services_Store.dart';

class ConsultationStoreRepositoryImp implements ConsultationStoreRepository {
  final ConsultationStoreDataSource dataSource;

  ConsultationStoreRepositoryImp(this.dataSource);

  @override
  Future<Response> addConsultationStore(consultationStore) async {
    try {
      final response = await dataSource.addConsultationStore(consultationStore);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response;
        } else {
          throw ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data["message"] ?? "Unknown error",
          );
        }
      }
      else {
        throw ServerFailure(
          statusCode: response.statusCode.toString(),
          message: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (dioException) {
      if (dioException.response?.statusCode == 404) {
        throw ServerFailure(
          statusCode: dioException.response?.statusCode.toString() ?? "",
          message: dioException.response?.data["message"] ?? "Not found",
        );
      } else {
        throw ServerFailure(
          statusCode: dioException.response?.statusCode.toString() ?? "",
          message: dioException.response?.data["message"] ?? "Unexpected error",
        );
      }
    }
  }
}
