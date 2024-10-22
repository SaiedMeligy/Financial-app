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
  int currentPage = 1;
  bool isLoading = false;
  bool isLastPage = false;
  List<Pationts> patients = [];
  AllPatientWithAdminCubit() : super(LoadingAllPatientWithAdmin());


  late AllPatientWithAdminUseCase allPatientUseCase;
  late AllPatientWithAdminRepository allPatientRepository;
  late AllPatientsWithAdminDataSource allPatientDataSource;

  Future<void> getAllPatientWithAdmin({bool loadMore =false}) async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    WebServices service = WebServices();
    allPatientDataSource = AllPatientWithAdminDataSourceImp(service.freeDio);
    allPatientRepository = AllPatientWithAdminRepositoryImp(allPatientDataSource);
    allPatientUseCase = AllPatientWithAdminUseCase(allPatientRepository);
    if(!loadMore)
    emit(LoadingAllPatientWithAdmin());
    try {
      var result = await allPatientUseCase.execute(AllPatientModel(),page: currentPage);
      final data = AllPatientModel.fromJson(result.data);
      if(data.pationts!.isEmpty){
        isLastPage = true;
      }
      else{
        currentPage++;
        patients.addAll(data.pationts?? []);
      }
      emit(SuccessAllPatientWithAdmin(patients));
    } catch (error) {
      emit(ErrorAllPatientWithAdmin(error.toString()));
    }finally{
      isLoading = false;
    }
  }
}

