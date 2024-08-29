import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../../../domain/repository/admin repository/patiens/AllPatientWithAdmin/all_patient_success_story_repository.dart';
import '../../../dataSource/admin/Patients/allPatientAdmin/allPatientSuccessStory/all_patients_admin_success_story_data_source.dart';



class AllPatientWithAdminSuccessStoryRepositoryImp implements AllPatientWithAdminSuccessStoryRepository{
  final AllPatientsWithAdminSuccessStoryDataSource dataSource;
  AllPatientWithAdminSuccessStoryRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllPatientWithAdminSuccessStory(AllPatientModel patientModel) async {
    try {
      final response = await dataSource.getAllPatientsWithAdminSuccessStory(
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


