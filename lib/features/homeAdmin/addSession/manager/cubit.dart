import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/domain/entities/AddSessionModel.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';
import 'package:experts_app/features/homeAdmin/addSession/page/add_session_view.dart';
import 'package:experts_app/main.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../core/Services/web_services.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import '../../../../data/dataSource/admin/Patients/getSessionDetails/get_session_details_data_source.dart';
import '../../../../data/dataSource/admin/Patients/getSessionDetails/get_session_details_data_source_imp.dart';
import '../../../../data/dataSource/admin/deleteSessionWithAdmin/delete_session_with_admin_data_source.dart';
import '../../../../data/dataSource/admin/deleteSessionWithAdmin/delete_session_with_admin_data_source_imp.dart';
import '../../../../data/dataSource/deleteQuestionFromForm/delete_question_form_data_source.dart';
import '../../../../data/dataSource/deleteQuestionFromForm/delete_question_form_data_source_imp.dart';
import '../../../../data/dataSource/getPatientDetails/get_patient_details_data_source.dart';
import '../../../../data/dataSource/getPatientDetails/get_patient_details_data_source_imp.dart';
import '../../../../data/dataSource/sessions/addSession/add_session_data_source.dart';
import '../../../../data/dataSource/sessions/addSession/add_session_data_source_imp.dart';
import '../../../../data/dataSource/sessions/deleteSession/delete_session_data_source.dart';
import '../../../../data/dataSource/sessions/deleteSession/delete_session_data_source_imp.dart';
import '../../../../data/dataSource/sessions/showSession/show_session_data_source.dart';
import '../../../../data/dataSource/sessions/showSession/show_session_data_source_imp.dart';
import '../../../../data/dataSource/sessions/showSessionWithAdmin/show_session_with_admin_data_source_imp.dart';
import '../../../../data/dataSource/sessions/showSessionWithAdmin/show_session_with_admindata_source.dart';
import '../../../../data/dataSource/sessions/updateSession/update_session_data_source.dart';
import '../../../../data/dataSource/sessions/updateSession/update_session_data_source_imp.dart';
import '../../../../data/repository_imp/add_session_repository_imp.dart';
import '../../../../data/repository_imp/admin_repository_imp/get_session_details_repository_imp.dart';
import '../../../../data/repository_imp/delete_question_from_form_repository_imp.dart';
import '../../../../data/repository_imp/delete_session_repository_imp.dart';
import '../../../../data/repository_imp/delete_session_with_admin_repository_imp.dart';
import '../../../../data/repository_imp/get_patient_details_repository_imp.dart';
import '../../../../data/repository_imp/show_session_repository_imp.dart';
import '../../../../data/repository_imp/show_session_with_Admin_repository_imp.dart';
import '../../../../data/repository_imp/update_session_repository_imp.dart';
import '../../../../domain/entities/QuestionModel.dart';
import '../../../../domain/entities/SessionUpdateModel.dart';
import '../../../../domain/repository/admin repository/deleteSessionWithAdmin/delete_session_with_admin_repository.dart';
import '../../../../domain/repository/admin repository/patiens/getSessionDetailsRepository/get_session_details_repository.dart';
import '../../../../domain/repository/deleteQuestionFromForm/delete_question_from_form_repository.dart';
import '../../../../domain/repository/getPatientDetailsRepository/get_patient_details_repository.dart';
import '../../../../domain/repository/sessions/addSession/add_session_repository.dart';
import '../../../../domain/repository/sessions/deleteSession/delete_session_repository.dart';
import '../../../../domain/repository/sessions/showSession/show_session_repository.dart';
import '../../../../domain/repository/sessions/showSessionWithAdmin/show_session_with_Admin_repository.dart';
import '../../../../domain/repository/sessions/updateSession/update_session_repository.dart';
import '../../../../domain/useCase/Sessions/addSession/add_session_use_case.dart';
import '../../../../domain/useCase/Sessions/deleteSession/delete_session_use_case.dart';
import '../../../../domain/useCase/Sessions/showSession/show_session_use_case.dart';
import '../../../../domain/useCase/Sessions/showSessionWithAdmin/show_session_with_admin_use_case.dart';
import '../../../../domain/useCase/Sessions/updateSession/update_session_use_case.dart';
import '../../../../domain/useCase/adminUseCase/deleteSessionWithAdmin/delete_session_with_admin_use_case.dart';
import '../../../../domain/useCase/adminUseCase/patiens/getSessionDetails/get_session_details_use_case.dart';
import '../../../../domain/useCase/deleteQuestionFromForm/delete_question_from_form_use_case.dart';
import '../../../../domain/useCase/getPatientDetails/get_patient_details_use_case.dart';
import '../../../homeAdvisor/sessions/manager/states.dart';

class AddSessionCubit extends Cubit<AddSessionStates> {
  AddSessionCubit() : super(LoadingAddSessionState());

  List<Pointers> pointers1 = [];
  List<Pointers> pointers2 = [];
  List<Pointers> pointers3 = [];

  late GetPatientDetailsUseCase getPatientDetailsUseCase;
  late GetPatientDetailsRepository getPatientDetailsRepository;
  late GetPatientDetailsDataSource getPatientDetailsDataSource;

  void emitSuccessState(dynamic data) {
    emit(SuccessPatientNationalIdState(data));
  }


  void emitErrorState(String errorMessage) {
    emit(ErrorAddSessionState(errorMessage));
  }

  void emitLoadingState() {
    emit(LoadingAddSessionState());
  }

  Future<void> setRefresh(String nationalId, int? with_all_questions) async {
    emitLoadingState();
    await getPatientDetails(nationalId, with_all_questions);
  }

  Future<void> setRefreshSession(int id) async {
    emitLoadingState();
    await showSession(id);
  }

  Future<void> setRefreshSessionAdmin(int id) async {
    emitLoadingState();
    await showSessionWithAdmin(id);
  }

  Future<void> setRefreshAdvicor(String nationalId) async {
    emitLoadingState();
    await getSessionDetails(nationalId, 0);
  }

  Future<void> getPatientDetails(String nationalId, int? with_all_questions) async {
    WebServices service = WebServices();
    getPatientDetailsDataSource = GetPatientDetailsDataSourceImp(service.freeDio);
    getPatientDetailsRepository = GetPatientDetailsRepositoryImp(getPatientDetailsDataSource);
    getPatientDetailsUseCase = GetPatientDetailsUseCase(getPatientDetailsRepository);

    try {
      final patientDetails = await getPatientDetailsUseCase.execute(nationalId, with_all_questions);
      if (patientDetails.data['pationt']["form"] == null) {
        SnackBarService.showErrorMessage("لم يسجل في الفورم");
        Navigator.of(navigatorKey.currentState!.context).pop();

        emitErrorState("لم يسجل في الفورم");
      } else {
        emitSuccessState(patientDetails);
      }
    } catch (e) {
      emitErrorState(e.toString());
    }
  }

  late AddSessionUseCase addSessionUseCase;
  late AddSessionRepository adviceRepository;
  late AddSessionDataSource addSessionDataSource;

  Future<Response> addSession(Sessions data, {bool isAdvicer = false}) async {
    WebServices services = WebServices();
    addSessionDataSource = AddSessionDataSourceImp(services.freeDio, isAdvicer: isAdvicer);
    adviceRepository = AddSessionRepositoryImp(addSessionDataSource);
    addSessionUseCase = AddSessionUseCase(adviceRepository);

    return await addSessionUseCase.execute(data);
  }

  late GetSessionDetailsUseCase getSessionDetailsUseCase;
  late GetSessionDetailsRepository getSessionDetailsRepository;
  late GetSessionDetailsDataSource getSessionDetailsDataSource;

  Future<void> getSessionDetails(String nationalId, int? with_all_questions) async {
    WebServices service = WebServices();
    getSessionDetailsDataSource = GetSessionDetailsDataSourceImp(service.freeDio);
    getSessionDetailsRepository = GetSessionDetailsRepositoryImp(getSessionDetailsDataSource);
    getSessionDetailsUseCase = GetSessionDetailsUseCase(getSessionDetailsRepository);

    emitLoadingState();
    try {
      final patientDetails = await getSessionDetailsUseCase.execute(nationalId, with_all_questions);
      if (patientDetails.data['pationt']["form"] == null) {
        SnackBarService.showErrorMessage("لم يسجل في الفورم");
        Navigator.of(navigatorKey.currentState!.context).pop();

        emitErrorState("لم يسجل في الفورم");
      } else {
        emit(SuccessAddSessionState(patientDetails));
      }
    } catch (e) {
      emitErrorState(e.toString());
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

  late ShowSessionUseCase showSessionUseCase;
  late ShowSessionRepository showSessionRepository;
  late ShowSessionDataSource showSessionDataSource;

  Future<void> showSession(int id) async {
    WebServices service = WebServices();
    showSessionDataSource = ShowSessionDataSourceImp(service.freeDio);
    showSessionRepository = ShowSessionRepositoryImp(showSessionDataSource);
    showSessionUseCase = ShowSessionUseCase(showSessionRepository);

    emitLoadingState();
    try {
      final showSession = await showSessionUseCase.execute(id);
      emit(SuccessShowSession(showSession));
    } catch (e) {
      emitErrorState(e.toString());
    }
  }

  late ShowSessionWithAdminUseCase showSessionWithAdminUseCase;
  late ShowSessionWithAdminRepository showSessionWithAdminRepository;
  late ShowSessionWithAdminDataSource showSessionWithAdminDataSource;

  late DeleteSessionUseCase deleteSessionUseCase;
  late DeleteSessionRepository deleteSessionRepository;
  late DeleteSessionDataSource deleteSessionDataSource;

  Future<void> deleteSession(int id) async {
    WebServices service = WebServices();
    deleteSessionDataSource = DeleteSessionDataSourceImp(service.freeDio);
    deleteSessionRepository = DeleteSessionRepositoryImp(deleteSessionDataSource);
    deleteSessionUseCase = DeleteSessionUseCase(deleteSessionRepository);

    emitLoadingState();
    try {
      final response = await deleteSessionUseCase.execute(id);
      emit(SuccessDeleteSession(response.data));
    } catch (error) {
      emitErrorState(error.toString());
    }
  }

  late DeleteQuestionFromFormUseCase deleteQuestionFromFormUseCase;
    late DeleteQuestionFromFormRepository deleteQuestionFromFormRepository;
  late DeleteQuestionFormDataSource deleteQuestionFromFormDataSource;

  Future<void> deleteQuestionFromForm(int questionId,int formId,bool isAdvisor) async {
    WebServices service = WebServices();
    deleteQuestionFromFormDataSource = DeleteQuestionFormDataSourceImp(service.freeDio);
    deleteQuestionFromFormRepository = DeleteQuestionFromFormRepositoryImp(deleteQuestionFromFormDataSource);
    deleteQuestionFromFormUseCase = DeleteQuestionFromFormUseCase(deleteQuestionFromFormRepository);

    emitLoadingState();
    try {
      final response = await deleteQuestionFromFormUseCase.execute(questionId,formId,isAdvisor);
      emit(SuccessDeleteQuestionFromForm(response.data));
    } catch (error) {
      emitErrorState(error.toString());
    }
  }

  late DeleteSessionWithAdminUseCase deleteSessionWithAdminUseCase;
  late DeleteSessionWithAdminRepository deleteSessionWithAdminRepository;
  late DeleteSessionWithAdminDataSource deleteSessionWithAdminDataSource;

  Future<void> deleteSessionWithAdmin(int id) async {
    WebServices service = WebServices();
    deleteSessionWithAdminDataSource = DeleteSessionWithAdminDataSourceImp(service.freeDio);
    deleteSessionWithAdminRepository = DeleteSessionWithAdminRepositoryImp(deleteSessionWithAdminDataSource);
    deleteSessionWithAdminUseCase = DeleteSessionWithAdminUseCase(deleteSessionWithAdminRepository);

    emitLoadingState();
    try {
      final response = await deleteSessionWithAdminUseCase.execute(id);
      emit(SuccessDeleteSession(response.data));
    } catch (error) {
      emitErrorState(error.toString());
    }
  }

  Future<void> showSessionWithAdmin(int id) async {
    WebServices service = WebServices();
    showSessionWithAdminDataSource = ShowSessionWithAdminDataSourceImp(service.freeDio);
    showSessionWithAdminRepository = ShowSessionWithAdminRepositoryImp(showSessionWithAdminDataSource);
    showSessionWithAdminUseCase = ShowSessionWithAdminUseCase(showSessionWithAdminRepository);

    emitLoadingState();
    try {
      final showSessionWithAdmin = await showSessionWithAdminUseCase.execute(id);
      emit(SuccessShowSessionWithAdmin(showSessionWithAdmin));
    } catch (e) {
      emitErrorState(e.toString());
    }
  }

  void onRefreshSession(RefreshController controller, BuildContext context) async {
    emitLoadingState();
    await Future.delayed(Duration(microseconds: 1000));
    controller.refreshCompleted();
  }
}