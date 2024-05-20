import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/data/dataSource/ConsultationServices/AllConsultation/all_consultation_data_source.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import 'package:experts_app/domain/repository/ConsultationServices/AllConsultations/all_consultation_repository.dart';

class AllConsultationRepositoryImp implements AllConsultationRepository{
  final AllConsultationDataSource dataSource;
  AllConsultationRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllConsultations(ConsultationModel consultationViewModel) async {
    try {
      final response = await dataSource.getAllConsultation(
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