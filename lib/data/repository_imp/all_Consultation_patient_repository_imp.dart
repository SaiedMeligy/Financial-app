import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../../../domain/entities/ConsultationViewModel.dart';
import '../../domain/repository/AllConsultationsWithPatient/all_consultation_patient_repository.dart';
import '../dataSource/AllConsultationWithPatient/all_consultation_patient_data_source.dart';

class AllConsultationPatientRepositoryImp implements AllConsultationPatientRepository{
  final AllConsultationPatientDataSource dataSource;
  AllConsultationPatientRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllConsultationPatient(ConsultationModel consultationViewModel) async {
    try {
      final response = await dataSource.getAllConsultationPatient(
          consultationViewModel);
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