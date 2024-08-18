import 'package:bloc/bloc.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/manager/states.dart';

import '../../../../data/dataSource/admin/Patients/allPatientAdmin/allPatients_admin_data_source_imp.dart';
import '../../../../data/dataSource/admin/Patients/allPatientAdmin/all_patients_admin_data_source.dart';
import '../../../../data/repository_imp/admin_repository_imp/patients/all_patient_repository_imp.dart';
import '../../../../domain/entities/AllPatientModel.dart';
import '../../../../domain/repository/admin repository/patiens/AllPatientWithAdmin/all_patient_repository.dart';
import '../../../../domain/useCase/adminUseCase/patiens/allpatient/all_patient_use_case.dart';

class AllPatientWithAdminCubit extends Cubit<AllPatientWithAdminStates> {
  AllPatientWithAdminCubit() : super(LoadingAllPatientWithAdmin());

  late AllPatientWithAdminUseCase allPatientUseCase;
  late AllPatientWithAdminRepository allPatientRepository;
  late AllPatientsWithAdminDataSource allPatientDataSource;

  Future<void> getAllPatientWithAdmin() async {
    WebServices service = WebServices();
    allPatientDataSource = AllPatientWithAdminDataSourceImp(service.freeDio);
    allPatientRepository = AllPatientWithAdminRepositoryImp(allPatientDataSource);
    allPatientUseCase = AllPatientWithAdminUseCase(allPatientRepository);
    emit(LoadingAllPatientWithAdmin());
    try {
      var result = await allPatientUseCase.execute(AllPatientModel());
      print('API Response: ${result.data}');

      final data = AllPatientModel.fromJson(result.data);
      emit(SuccessAllPatientWithAdmin(data.pationts ?? []));
    } catch (error) {
      emit(ErrorAllPatientWithAdmin(error.toString()));
    }
  }
}

// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:experts_app/core/Services/snack_bar_service.dart';
// import 'package:experts_app/core/Services/web_services.dart';
// import 'package:experts_app/features/homeAdmin/allPatientsAdmin/manager/states.dart';
// import '../../../../data/dataSource/admin/Patients/allPatientAdmin/allPatients_admin_data_source_imp.dart';
// import '../../../../data/dataSource/admin/Patients/allPatientAdmin/all_patients_admin_data_source.dart';
// import '../../../../data/repository_imp/admin_repository_imp/patients/all_patient_repository_imp.dart';
// import '../../../../domain/entities/AllPatientModel.dart';
// import '../../../../domain/repository/admin repository/patiens/AllPatientWithAdmin/all_patient_repository.dart';
// import '../../../../domain/useCase/adminUseCase/patiens/allpatient/all_patient_use_case.dart';
//
// class AllPatientWithAdminCubit extends Cubit<AllPatientWithAdminStates> {
//   AllPatientWithAdminCubit() : super(LoadingAllPatientWithAdmin());
//
//   late AllPatientWithAdminUseCase allPatientUseCase;
//   late AllPatientWithAdminRepository allPatientRepository;
//   late AllPatientsWithAdminDataSource allPatientDataSource;
//
//   Future<void> getAllPatientWithAdmin() async {
//     WebServices service = WebServices();
//     allPatientDataSource = AllPatientWithAdminDataSourceImp(service.freeDio);
//     allPatientRepository = AllPatientWithAdminRepositoryImp(allPatientDataSource);
//     allPatientUseCase = AllPatientWithAdminUseCase(allPatientRepository);
//     emit(LoadingAllPatientWithAdmin());
//     try {
//       var result = await allPatientUseCase.execute(AllPatientModel());
//       print('API Response: ${result.data}');
//       final data = AllPatientModel.fromJson(result.data);
//       emit(SuccessAllPatientWithAdmin(data.pationts ?? []));
//     } catch (error) {
//       String errorMessage = "Unknown error occurred.";
//
//       if (error is DioException) {
//         switch (error.type) {
//           case DioExceptionType.connectionError:
//             errorMessage = "No internet connection. Please check your network.";
//             SnackBarService.showErrorMessage(errorMessage);
//             break;
//           case DioExceptionType.connectionTimeout:
//           case DioExceptionType.sendTimeout:
//           case DioExceptionType.receiveTimeout:
//             errorMessage = "Request timeout. Please try again later.";
//             break;
//           case DioExceptionType.cancel:
//             errorMessage = "Request was cancelled.";
//             break;
//           case DioExceptionType.badResponse:
//             errorMessage = error.response?.data["message"] ?? "Bad response from server.";
//             break;
//           case DioExceptionType.unknown:
//             errorMessage = "Unexpected error occurred. Please try again.";
//             break;
//           case DioExceptionType.connectionError:
//            errorMessage = "Connection error. Please try again";
//            SnackBarService.showErrorMessage(errorMessage);
//           case DioExceptionType.badCertificate:
//             // TODO: Handle this case.
//         }
//       } else {
//         errorMessage = error.toString();
//       }
//
//       emit(ErrorAllPatientWithAdmin(errorMessage));
//     }
//   }
// }