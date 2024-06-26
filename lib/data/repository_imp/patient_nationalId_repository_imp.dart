import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';

import '../../domain/entities/AdviceMode.dart';
import '../../domain/entities/pointerModel.dart';
import '../../domain/repository/patientNationalIdRepository/patient_nationalId_repository.dart';
import '../dataSource/patientNationalId/patient_nationalId_data_source.dart';

class PatientNationalIdRepositoryImp implements PatientNationalIdRepository{
  final PatientNationalIdDataSource dataSource;
  PatientNationalIdRepositoryImp(this.dataSource);
  @override
  Future<Response> getPatientNationalId(String nationalId) async {
    try {
      final response = await dataSource.getNationalId(
          nationalId);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          SnackBarService.showSuccessMessage(response.data["message"]);

          print("--------->"+response.toString());

          return response;
        }
        else {
          SnackBarService.showErrorMessage(response.data["message"]);
          throw ServerFailure(statusCode: response.statusCode.toString(),
              message: response.data["message"] ?? "unKnown error"
          );
        }
      }
      else{
        SnackBarService.showErrorMessage(response.data["message"]);

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