import 'package:bloc/bloc.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/manager/states.dart';

import '../../../../data/dataSource/admin/Patients/allPatientAdmin/allPatientNeedOtherSession/allPatients_admin_need_other_session_data_source_imp.dart';
import '../../../../data/dataSource/admin/Patients/allPatientAdmin/allPatientNeedOtherSession/all_patients_admin_need_other_Session_data_source.dart';
import '../../../../data/dataSource/admin/Patients/allPatientAdmin/allPatientNoNeedOtherSession/allPatients_admin_no_need_other_session_data_source_imp.dart';
import '../../../../data/dataSource/admin/Patients/allPatientAdmin/allPatientNoNeedOtherSession/all_patients_admin_no_need_other_Session_data_source.dart';
import '../../../../data/dataSource/admin/Patients/allPatientAdmin/allPatientSuccessStory/allPatients_admin_success_story_data_source_imp.dart';
import '../../../../data/dataSource/admin/Patients/allPatientAdmin/allPatientSuccessStory/all_patients_admin_success_story_data_source.dart';
import '../../../../data/dataSource/admin/Patients/allPatientAdmin/allPatients_admin_data_source_imp.dart';
import '../../../../data/dataSource/admin/Patients/allPatientAdmin/all_patients_admin_data_source.dart';
import '../../../../data/repository_imp/admin_repository_imp/patients/all_patient_need_other_session_repository_imp.dart';
import '../../../../data/repository_imp/admin_repository_imp/patients/all_patient_no_need_other_session_repository_imp.dart';
import '../../../../data/repository_imp/admin_repository_imp/patients/all_patient_repository_imp.dart';
import '../../../../data/repository_imp/admin_repository_imp/patients/all_patient_success_Story_repository_imp.dart';
import '../../../../domain/entities/AllPatientModel.dart';
import '../../../../domain/repository/admin repository/patiens/AllPatientWithAdmin/all_patient_need_other_session_repository.dart';
import '../../../../domain/repository/admin repository/patiens/AllPatientWithAdmin/all_patient_no_need_other_session_repository.dart';
import '../../../../domain/repository/admin repository/patiens/AllPatientWithAdmin/all_patient_repository.dart';
import '../../../../domain/repository/admin repository/patiens/AllPatientWithAdmin/all_patient_success_story_repository.dart';
import '../../../../domain/useCase/adminUseCase/patiens/allpatient/all_patient_need_other_session_use_case.dart';
import '../../../../domain/useCase/adminUseCase/patiens/allpatient/all_patient_no_need_other_session_use_case.dart';
import '../../../../domain/useCase/adminUseCase/patiens/allpatient/all_patient_success_story_use_case.dart';
import '../../../../domain/useCase/adminUseCase/patiens/allpatient/all_patient_use_case.dart';

class AllPatientWithAdminCubit extends Cubit<AllPatientWithAdminStates> {
  int currentPage = 1;
  bool isLastPage = false;
  bool isLoading = false;
  String currentSearchQuery = '';
  List<Pationts> patients = [];
    AllPatientWithAdminCubit() : super(LoadingAllPatientWithAdmin());

  late AllPatientWithAdminUseCase allPatientUseCase;
  late AllPatientWithAdminRepository allPatientRepository;
  late AllPatientsWithAdminDataSource allPatientDataSource;

  Future<void> getAllPatientWithAdmin({bool loadMore=false,String? searchQuery}) async {
    if(searchQuery!=null && !loadMore){
      if(searchQuery == currentSearchQuery)return;
      isLastPage = false;
      currentPage=1;
      currentSearchQuery=searchQuery;
      patients = [];
    }
    if(isLastPage||isLoading) return;
    isLoading = true;
    WebServices service = WebServices();
    allPatientDataSource = AllPatientWithAdminDataSourceImp(service.freeDio);
    allPatientRepository = AllPatientWithAdminRepositoryImp(allPatientDataSource);
    allPatientUseCase = AllPatientWithAdminUseCase(allPatientRepository);
    if (!loadMore) emit(LoadingAllPatientWithAdmin());
    try {
      var result = await allPatientUseCase.execute(AllPatientModel(),page: currentPage,searchQuery: currentSearchQuery);
      final data = AllPatientModel.fromJson(result.data);
      if(data.pationts!.isEmpty){
        isLastPage = true;
      }
      else{
        currentPage++;
        patients.addAll(data.pationts??[]);
      }
      emit(SuccessAllPatientWithAdmin(patients ?? []));
    } catch (error) {
      emit(ErrorAllPatientWithAdmin(error.toString()));
    }finally{
      isLoading = false;
    }
  }

  late AllPatientWithAdminNeedOtherSessionUseCase allPatientNeedOtherSessionUseCase;
  late AllPatientWithAdminNeedOtherSessionRepository allPatientNeedOtherSessionRepository;
  late AllPatientsWithAdminNeedOtherSessionDataSource allPatientNeedOtherSessionDataSource;

  Future<void> getAllPatientWithAdminNeedOtherSession() async {
    WebServices service = WebServices();
    allPatientNeedOtherSessionDataSource = AllPatientWithAdminNeedOtherSessionDataSourceImp(service.freeDio);
    allPatientNeedOtherSessionRepository = AllPatientWithAdminNeedOtherSessionRepositoryImp(allPatientNeedOtherSessionDataSource);
    allPatientNeedOtherSessionUseCase = AllPatientWithAdminNeedOtherSessionUseCase(allPatientNeedOtherSessionRepository);
    emit(LoadingAllPatientWithAdmin());
    try {
      var result = await allPatientNeedOtherSessionUseCase.execute(AllPatientModel());
      print('API Response: ${result.data}');

      final data = AllPatientModel.fromJson(result.data);
      emit(SuccessAllPatientWithAdmin(data.pationts ?? []));
    } catch (error) {
      emit(ErrorAllPatientWithAdmin(error.toString()));
    }
  }

  late AllPatientWithAdminNoNeedOtherSessionUseCase allPatientNoNeedOtherSessionUseCase;
  late AllPatientWithAdminNoNeedOtherSessionRepository allPatientNoNeedOtherSessionRepository;
  late AllPatientsWithAdminNoNeedOtherSessionDataSource allPatientNoNeedOtherSessionDataSource;

  Future<void> getAllPatientWithAdminNoNeedOtherSession() async {
    WebServices service = WebServices();
    allPatientNoNeedOtherSessionDataSource = AllPatientWithAdminNoNeedOtherSessionDataSourceImp(service.freeDio);
    allPatientNoNeedOtherSessionRepository = AllPatientWithAdminNoNeedOtherSessionRepositoryImp(allPatientNoNeedOtherSessionDataSource);
    allPatientNoNeedOtherSessionUseCase = AllPatientWithAdminNoNeedOtherSessionUseCase(allPatientNoNeedOtherSessionRepository);
    emit(LoadingAllPatientWithAdmin());
    try {
      var result = await allPatientNoNeedOtherSessionUseCase.execute(AllPatientModel());
      print('API Response: ${result.data}');

      final data = AllPatientModel.fromJson(result.data);
      emit(SuccessAllPatientWithAdmin(data.pationts ?? []));
    } catch (error) {
      emit(ErrorAllPatientWithAdmin(error.toString()));
    }
  }


  late AllPatientWithAdminSuccessStoryUseCase allPatientSuccessStoryUseCase;
  late AllPatientWithAdminSuccessStoryRepository allPatientSuccessStoryRepository;
  late AllPatientsWithAdminSuccessStoryDataSource allPatientSuccessStoryDataSource;

  Future<void> getAllPatientWithAdminSuccessStory() async {
    WebServices service = WebServices();
    allPatientSuccessStoryDataSource = AllPatientWithAdminSuccessStoryDataSourceImp(service.freeDio);
    allPatientSuccessStoryRepository = AllPatientWithAdminSuccessStoryRepositoryImp(allPatientSuccessStoryDataSource);
    allPatientSuccessStoryUseCase = AllPatientWithAdminSuccessStoryUseCase(allPatientSuccessStoryRepository);
    emit(LoadingAllPatientWithAdmin());
    try {
      var result = await allPatientSuccessStoryUseCase.execute(AllPatientModel());
      print('API Response: ${result.data}');

      final data = AllPatientModel.fromJson(result.data);
      emit(SuccessAllPatientWithAdmin(data.pationts ?? []));
    } catch (error) {
      emit(ErrorAllPatientWithAdmin(error.toString()));
    }
  }

void updatePatientLocally(Pationts updatedPatient) {
  final index = patients.indexWhere((p) => p.id == updatedPatient.id);
  if (index != -1) {
    patients[index] = updatedPatient;
    emit(SuccessAllPatientWithAdmin(patients));
  }
}
}


