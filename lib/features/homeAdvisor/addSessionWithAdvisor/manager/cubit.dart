import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/domain/entities/AddSessionModel.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';
import 'package:experts_app/main.dart';

import '../../../../core/Failure/server_failure.dart';
import '../../../../core/Services/web_services.dart';
import '../../../../data/dataSource/admin/Patients/getSessionDetails/get_session_details_data_source.dart';
import '../../../../data/dataSource/admin/Patients/getSessionDetails/get_session_details_data_source_imp.dart';
import '../../../../data/dataSource/getPatientDetails/get_patient_details_data_source.dart';
import '../../../../data/dataSource/getPatientDetails/get_patient_details_data_source_imp.dart';
import '../../../../data/dataSource/sessions/addSession/add_session_data_source.dart';
import '../../../../data/dataSource/sessions/addSession/add_session_data_source_imp.dart';
import '../../../../data/dataSource/sessions/updateSession/update_session_data_source.dart';
import '../../../../data/dataSource/sessions/updateSession/update_session_data_source_imp.dart';
import '../../../../data/repository_imp/add_session_repository_imp.dart';
import '../../../../data/repository_imp/admin_repository_imp/get_session_details_repository_imp.dart';
import '../../../../data/repository_imp/get_patient_details_repository_imp.dart';
import '../../../../data/repository_imp/update_session_repository_imp.dart';
import '../../../../domain/entities/SessionUpdateModel.dart';
import '../../../../domain/repository/admin repository/patiens/getSessionDetailsRepository/get_session_details_repository.dart';
import '../../../../domain/repository/getPatientDetailsRepository/get_patient_details_repository.dart';
import '../../../../domain/repository/sessions/addSession/add_session_repository.dart';
import '../../../../domain/repository/sessions/updateSession/update_session_repository.dart';
import '../../../../domain/useCase/Sessions/addSession/add_session_use_case.dart';
import '../../../../domain/useCase/Sessions/updateSession/update_session_use_case.dart';
import '../../../../domain/useCase/adminUseCase/patiens/getSessionDetails/get_session_details_use_case.dart';
import '../../../../domain/useCase/getPatientDetails/get_patient_details_use_case.dart';

class AddSessionCubit extends Cubit<AddSessionStates> {
  AddSessionCubit() : super(LoadingAddSessionState());


  late GetPatientDetailsUseCase getPatientDetailsUseCase;
  late GetPatientDetailsRepository getPatientDetailsRepository;
  late GetPatientDetailsDataSource getPatientDetailsDataSource;

  Future<void> setRefresh(String nationalId) async {
    emit(LoadingAddSessionState());
    getSessionDetails(nationalId);
  }
  Future<void> getPatientDetails(String nationalId) async {
    WebServices service = WebServices();
    getPatientDetailsDataSource =
        GetPatientDetailsDataSourceImp(service.freeDio);
    getPatientDetailsRepository =
        GetPatientDetailsRepositoryImp(getPatientDetailsDataSource);
    getPatientDetailsUseCase =
        GetPatientDetailsUseCase(getPatientDetailsRepository);
    try {
      final patientDetails = await getPatientDetailsUseCase.execute(nationalId);
      if(patientDetails.data['pationt']["form"]==null  ) {
        SnackBarService.showErrorMessage("لم يسجل في الفورم");
        emit(ErrorFormState());
      }
      else {
        emit(SuccessPatientNationalIdState(patientDetails));

      }

    }
    catch (e) {
      emit(ErrorAddSessionState(e.toString()));
    }
  }

  late AddSessionUseCase addSessionUseCase;
  late AddSessionRepository adviceRepository;
  late AddSessionDataSource addSessionDataSource;


  Future<Response> addSession(Sessions data) async {
    WebServices services = WebServices();
    addSessionDataSource = AddSessionDataSourceImp(services.freeDio);
    adviceRepository = AddSessionRepositoryImp(addSessionDataSource);
    addSessionUseCase = AddSessionUseCase(adviceRepository);

    return await addSessionUseCase.execute(data);
  }


  late GetSessionDetailsUseCase getSessionDetailsUseCase;
  late GetSessionDetailsRepository getSessionDetailsRepository;
  late GetSessionDetailsDataSource getSessionDetailsDataSource;

  Future<void> getSessionDetails(String nationalId) async {
    WebServices service = WebServices();
    getSessionDetailsDataSource =
        GetSessionDetailsDataSourceImp(service.freeDio);
    getSessionDetailsRepository =
        GetSessionDetailsRepositoryImp(getSessionDetailsDataSource);
    getSessionDetailsUseCase =
        GetSessionDetailsUseCase(getSessionDetailsRepository);
    emit(LoadingAddSessionState());
    try {
      final patientDetails = await getSessionDetailsUseCase.execute(nationalId);
      if(patientDetails.data['pationt']["form"]==null  ) {
        SnackBarService.showErrorMessage("لم يسجل في الفورم");
        emit(ErrorFormState());
      }
      else {
        emit(SuccessAddSessionState(patientDetails));
      }

    }
    catch (e) {
      emit(ErrorAddSessionState(e.toString()));
    }
  }

  late UpdateSessionUseCase updateSessionUseCase;
  late UpdateSessionRepository updateRepository;
  late UpdateSessionDataSource updateSessionDataSource;


  Future<Response> updateSession(SessionsUpdateModel data) async {
    WebServices services = WebServices();
    updateSessionDataSource = UpdateSessionDataSourceImp(services.freeDio);
    updateRepository = UpdateSessionRepositoryImp(updateSessionDataSource);
    updateSessionUseCase = UpdateSessionUseCase(updateRepository);

    return await updateSessionUseCase.execute(data);
  }


  // Future<void> getSessionDetails(String nationalId) async {
  //   final Dio dio = Dio();
  //   try {
  //     final response = await dio.get("/api/advicor/pationt/show",
  //         queryParameters: {
  //           "national_Id": nationalId,
  //         },
  //         options: Options(
  //             headers: {
  //               "api-password": Constants.apiPassword,
  //               "token": CacheHelper.getData(key: "token")
  //             }
  //         )
  //     );
  //     if (response.statusCode == 200) {
  //         emit(SuccessAddSessionState(response));
  //       }
  //     else {
  //       throw ServerFailure(statusCode: response.statusCode.toString(),
  //           message: response.data["message"] ?? "unKnown error"
  //       );
  //     }
  //   }
  //   on DioException catch (dioException){
  //     throw ServerFailure(statusCode: dioException.response?.statusCode.toString()??"",
  //         message: dioException.response?.data["message"]?? "unKnown error");
  //   }
  // }
  }
