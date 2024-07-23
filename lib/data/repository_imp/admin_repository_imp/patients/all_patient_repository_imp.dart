import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../../../domain/repository/admin repository/patiens/AllPatientWithAdmin/all_patient_repository.dart';
import '../../../dataSource/admin/Patients/allPatientAdmin/all_patients_admin_data_source.dart';


class AllPatientWithAdminRepositoryImp implements AllPatientWithAdminRepository{
  final AllPatientsWithAdminDataSource dataSource;
  AllPatientWithAdminRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllPatientWithAdmin(AllPatientModel patientModel) async {
    try {
      final response = await dataSource.getAllPatientsWithAdmin(
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


// import 'package:dio/dio.dart';
// import 'package:experts_app/core/Failure/server_failure.dart';
// import 'package:experts_app/core/Services/snack_bar_service.dart';
// import 'package:experts_app/data/dataSource/allPatient/all_patients_data_source.dart';
// import 'package:experts_app/domain/entities/AllPatientModel.dart';
//
// import '../../../../domain/repository/admin repository/patiens/AllPatientWithAdmin/all_patient_repository.dart';
// import '../../../dataSource/admin/Patients/allPatientAdmin/all_patients_admin_data_source.dart';
//
// class AllPatientWithAdminRepositoryImp implements AllPatientWithAdminRepository {
//   final AllPatientsWithAdminDataSource dataSource;
//
//   AllPatientWithAdminRepositoryImp(this.dataSource);
//
//   @override
//   Future<Response> getAllPatientWithAdmin(AllPatientModel patientModel) async {
//     try {
//       final response = await dataSource.getAllPatientsWithAdmin(patientModel);
//       if (response.statusCode == 200) {
//         if (response.data["status"] == true) {
//           return response;
//         } else {
//           throw ServerFailure(
//             statusCode: response.statusCode.toString(),
//             message: response.data["message"] ?? "Unknown error",
//           );
//         }
//       } else {
//         throw ServerFailure(
//           statusCode: response.statusCode.toString(),
//           message: response.data["message"] ?? "Unknown error",
//         );
//       }
//     } on DioException catch (dioException) {
//       String errorMessage;
//
//       switch (dioException.type) {
//         case DioExceptionType.connectionTimeout:
//         case DioExceptionType.sendTimeout:
//         case DioExceptionType.receiveTimeout:
//           errorMessage = "Request timeout. Please try again later.";
//           SnackBarService.showErrorMessage(errorMessage);
//           break;
//         case DioExceptionType.cancel:
//           errorMessage = "Request was cancelled.";
//           SnackBarService.showErrorMessage(errorMessage);
//           break;
//         case DioExceptionType.badResponse:
//           errorMessage = dioException.response?.data["message"] ?? "Unknown error";
//           SnackBarService.showErrorMessage(errorMessage);
//           break;
//         case DioExceptionType.connectionError:
//           errorMessage = "No internet connection. Please check your connection and try again.";
//           SnackBarService.showErrorMessage(errorMessage);
//           break;
//         case DioExceptionType.connectionError:
//           errorMessage = "no internet.";
//           SnackBarService.showErrorMessage(errorMessage);
//           break;
//         default:
//           errorMessage = "Unknown error occurred. Please try again.";
//           SnackBarService.showErrorMessage(errorMessage);
//       }
//
//       throw ServerFailure(
//         statusCode: dioException.response?.statusCode?.toString() ?? "",
//         message: errorMessage,
//       );
//     }
//   }
// }
