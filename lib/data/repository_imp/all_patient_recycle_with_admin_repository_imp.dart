import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import '../../domain/entities/AllPatientModel.dart';
import '../../domain/repository/admin repository/all_patient_recycle_with_admin_repository.dart';
import '../dataSource/admin/Patients/allPatientAdmin/recycle/all_patients_admin_data_source.dart';

class AllPatientRecycleWithAdminRepositoryImp implements AllPatientRecycleWithAdminRepository{
  final AllPatientsRecycleWithAdminDataSource dataSource;
  AllPatientRecycleWithAdminRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllPatientRecycleWithAdmin(AllPatientModel patientModel,int recycle) async {
    try {
      final response = await dataSource.getAllPatientsRecycleWithAdmin(patientModel,recycle);
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