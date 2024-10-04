import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/data/dataSource/allPatient/all_patients_data_source.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';
import '../../domain/repository/AllPatient/all_patient_repository.dart';

class AllPatientRepositoryImp implements AllPatientRepository{
  final AllPatientsDataSource dataSource;
  AllPatientRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllPatient(AllPatientModel patientModel) async {
    try {
      final response = await dataSource.getAllPatients(
          patientModel);
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