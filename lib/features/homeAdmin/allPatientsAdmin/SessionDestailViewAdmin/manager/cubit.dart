import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/data/dataSource/sessions/evaluationSession/evaluation_session_data_source.dart';
import 'package:experts_app/domain/entities/EvaluationModel.dart';
import 'package:experts_app/domain/useCase/evaluationSession/evaluation_session_use_case.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/SessionDestailViewAdmin/manager/states.dart';

import '../../../../../core/Services/snack_bar_service.dart';
import '../../../../../core/Services/web_services.dart';
import '../../../../../data/dataSource/admin/Patients/getSessionDetails/get_session_details_data_source.dart';
import '../../../../../data/dataSource/admin/Patients/getSessionDetails/get_session_details_data_source_imp.dart';
import '../../../../../data/dataSource/getPatientDetails/get_patient_details_data_source.dart';
import '../../../../../data/dataSource/getPatientDetails/get_patient_details_data_source_imp.dart';
import '../../../../../data/dataSource/sessions/addSession/add_session_data_source.dart';
import '../../../../../data/dataSource/sessions/addSession/add_session_data_source_imp.dart';
import '../../../../../data/dataSource/sessions/addSessionEvaluation/add_session_evaluation_data_source.dart';
import '../../../../../data/dataSource/sessions/addSessionEvaluation/add_session_evaluation_data_source_imp.dart';
import '../../../../../data/dataSource/sessions/deleteEvaluationSession/delete_evaluation_session_data_source.dart';
import '../../../../../data/dataSource/sessions/deleteEvaluationSession/delete_evaluation_session_data_source_imp.dart';
import '../../../../../data/dataSource/sessions/evaluationSession/evaluation_data_source_imp.dart';
import '../../../../../data/dataSource/sessions/updateEvaluationSession/update_evaluation_session_data_source.dart';
import '../../../../../data/dataSource/sessions/updateEvaluationSession/update_evaluation_session_data_source_imp.dart';
import '../../../../../data/dataSource/sessions/updateSession/update_session_data_source.dart';
import '../../../../../data/dataSource/sessions/updateSession/update_session_data_source_imp.dart';
import '../../../../../data/repository_imp/add_session_evaluation_repository_imp.dart';
import '../../../../../data/repository_imp/add_session_repository_imp.dart';
import '../../../../../data/repository_imp/admin_repository_imp/get_session_details_repository_imp.dart';
import '../../../../../data/repository_imp/delete_evaluation_session_repository_imp.dart';
import '../../../../../data/repository_imp/evaluation_session_repository_imp.dart';
import '../../../../../data/repository_imp/get_patient_details_repository_imp.dart';
import '../../../../../data/repository_imp/update_evaluation_session_repository_imp.dart';
import '../../../../../data/repository_imp/update_session_repository_imp.dart';
import '../../../../../domain/entities/AddSessionModel.dart';
import '../../../../../domain/entities/SessionUpdateModel.dart';
import '../../../../../domain/repository/admin repository/patiens/getSessionDetailsRepository/get_session_details_repository.dart';
import '../../../../../domain/repository/getPatientDetailsRepository/get_patient_details_repository.dart';
import '../../../../../domain/repository/sessions/addSession/add_session_repository.dart';
import '../../../../../domain/repository/sessions/addSessionEvaluation/add_session_evaluation _repository.dart';
import '../../../../../domain/repository/sessions/deleteEvaluationSession/delete_evaluation_session_repository.dart';
import '../../../../../domain/repository/sessions/evaluationSession/evaluation_session_repo.dart';
import '../../../../../domain/repository/sessions/updateEvaluationSession/update_evaluation_session_repository.dart';
import '../../../../../domain/repository/sessions/updateSession/update_session_repository.dart';
import '../../../../../domain/useCase/Sessions/addSession/add_session_use_case.dart';
import '../../../../../domain/useCase/Sessions/addSessionEvaluation/add_session_evaluation_use_case.dart';
import '../../../../../domain/useCase/Sessions/deleteEvaluationSession/delete_evaluation_session_use_case.dart';
import '../../../../../domain/useCase/Sessions/updateEvaluationSession/update_evaluation_session_use_case.dart';
import '../../../../../domain/useCase/Sessions/updateSession/update_session_use_case.dart';
import '../../../../../domain/useCase/adminUseCase/patiens/getSessionDetails/get_session_details_use_case.dart';
import '../../../../../domain/useCase/getPatientDetails/get_patient_details_use_case.dart';

class SessionCubit extends Cubit<States> {
  SessionCubit() : super(LoadingSessionState());
  late EvaluationModel evaluation;


  late GetPatientDetailsUseCase getPatientDetailsUseCase;
  late GetPatientDetailsRepository getPatientDetailsRepository;
  late GetPatientDetailsDataSource getPatientDetailsDataSource;

  Future<void> setRefresh(String nationalId) async {
    emit(LoadingSessionState());
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
      final patientDetails = await getPatientDetailsUseCase.execute(nationalId,0);
      if(patientDetails.data['pationt']["form"]==null  ) {
        SnackBarService.showErrorMessage("لم يسجل في الفورم");
        emit(ErrorFormState());
      }
      else {
        emit(SuccessNationalIdState(patientDetails));
      }

    }
    catch (e) {
      emit(ErrorSessionState(e.toString()));
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
    emit(LoadingSessionState());
    try {
      final patientDetails = await getSessionDetailsUseCase.execute(nationalId,0);
      if(patientDetails.data['pationt']["form"]==null  ) {
        SnackBarService.showErrorMessage("لم يسجل في الفورم");
        emit(ErrorFormState());
      }
      else {
        emit(SuccessSessionState(patientDetails));
      }

    }
    catch (e) {
      emit(ErrorSessionState(e.toString()));
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

  late EvaluationSessionUseCase evaluationSessionUseCase;
  late EvaluationSessionRepository evaluationSessionRepository;
  late EvaluationSessionDataSource evaluationSessionDataSource;


  Future<void> evaluateSession  (int? sessionId,int? formId)async{
    WebServices services = WebServices();
    evaluationSessionDataSource = EvaluationSessionDataSourceImp(services.freeDio);
    evaluationSessionRepository = EvaluationSessionRepositoryImp(evaluationSessionDataSource);
    evaluationSessionUseCase = EvaluationSessionUseCase(evaluationSessionRepository);
    emit(LoadingEvaluationSessionState());


    final result = await evaluationSessionUseCase.execute(sessionId,formId);
    evaluation= EvaluationModel.fromJson(result.data);
    emit(SuccessEvaluationSessionState(evaluation.sessionPointersEvaluation??[]));
  }

  late UpdateEvaluationSessionUseCase evaluationUpdateSessionUseCase;
  late UpdateEvaluationSessionRepository evaluationUpdateSessionRepository;
  late UpdateEvaluationSessionDataSource evaluationUpdateSessionDataSource;

  Future<Response> evaluateUpdateSession  ({required int id,required int evaluation})async{
    WebServices services = WebServices();
    evaluationUpdateSessionDataSource = UpdateEvaluationSessionDataSourceImp(services.freeDio);
    evaluationUpdateSessionRepository = UpdateEvaluationSessionRepositoryImp(evaluationUpdateSessionDataSource);
    evaluationUpdateSessionUseCase = UpdateEvaluationSessionUseCase(evaluationUpdateSessionRepository);
    emit(LoadingEvaluationSessionState());


    return await evaluationUpdateSessionUseCase.execute(id,evaluation);
  }

  late DeleteEvaluationSessionUseCase evaluationDeleteSessionUseCase;
  late DeleteEvaluationSessionRepository evaluationDeleteSessionRepository;
  late DeleteEvaluationSessionDataSource evaluationDeleteSessionDataSource;

  Future<Response> evaluateDeleteSession  (int id,)async{
    WebServices services = WebServices();
    evaluationDeleteSessionDataSource = DeleteEvaluationSessionDataSourceImp(services.freeDio);
    evaluationDeleteSessionRepository = DeleteEvaluationSessionRepositoryImp(evaluationDeleteSessionDataSource);
    evaluationDeleteSessionUseCase = DeleteEvaluationSessionUseCase(evaluationDeleteSessionRepository);
    emit(LoadingEvaluationSessionState());


    return await evaluationDeleteSessionUseCase.execute(id,);
  }

  late AddSessionEvaluationUseCase addSessionEvaluationUseCase;
  late AddSessionEvaluationRepository addSessionRepository;
  late AddSessionEvaluationDataSource addSessionEvaluationDataSource;


  Future<Response> addSessionEvaluation(List<Map<String, String>>?  pointerEvaluation,int? sessionId,int? formId) async {
    WebServices services = WebServices();
    addSessionEvaluationDataSource = AddSessionEvaluationDataSourceImp(services.freeDio);
    addSessionRepository = AddSessionEvaluationRepositoryImp(addSessionEvaluationDataSource);
    addSessionEvaluationUseCase = AddSessionEvaluationUseCase(addSessionRepository);

    return await addSessionEvaluationUseCase.execute(pointerEvaluation,sessionId,formId);
  }


}
