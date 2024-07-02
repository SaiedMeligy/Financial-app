import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';

import '../../../../domain/repository/admin repository/form/patientFormViewRepository/patient_form_view_repository.dart';
import '../../../dataSource/admin/form/patientFormView/patient_form_view_admin_data_source.dart';


class PatientFormViewWithAdminRepositoryImp implements PatientFormViewWithAdminRepository{
  final PatientFormViewWithAdminDataSource dataSource;
  PatientFormViewWithAdminRepositoryImp(this.dataSource);
  @override
  Future<Response> getPatientFormViewWithAdmin(int patientId) async {
    try {
      final response = await dataSource.getPatientFormWithAdmin(
          patientId);
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