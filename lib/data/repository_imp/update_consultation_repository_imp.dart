import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/data/dataSource/ConsultationServices/updateConsultation/Consultation_update_data_source.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import 'package:experts_app/domain/repository/ConsultationServices/updateConsultation/update_consultation_repository.dart';

import '../../domain/repository/ConsultationServices/ConsultationStore/consultation_store_repository.dart';
import '../dataSource/ConsultationServices/ConsultationStore/Consultation_Services_Store.dart';

class UpdateConsultationRepositoryImp implements UpdateConsultationRepository {
  final UpdateConsultationDataSource dataSource;

  UpdateConsultationRepositoryImp(this.dataSource);

  @override
  Future<Response> updateConsultation(int id,String name,String description) async {
    try {
      final response = await dataSource.updateConsultation(id,name,description);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response;
        }
        else {
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
        throw ServerFailure(
          statusCode: dioException.response?.statusCode.toString() ?? "",
          message: dioException.response?.data["message"] ?? "Not found",
        );
      }

  }
}
