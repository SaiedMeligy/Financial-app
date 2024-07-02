import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/data/dataSource/allPatient/recycle/all_patients_data_source.dart';

import '../../../../domain/entities/AllPatientModel.dart';
import '../../../../domain/repository/admin repository/patiens/AllPatientWithAdmin/all_patient_recycle_repository.dart';

class AllPatientRecycleWithAdminRepositoryImp implements AllPatientRecycleWithAdminRepository{
  final AllPatientsRecycleDataSource dataSource;
  AllPatientRecycleWithAdminRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllPatientRecycleWithAdmin(AllPatientModel patientModel,int recycle) async {
    try {
      final response = await dataSource.getAllPatientsRecycle(patientModel,recycle);
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