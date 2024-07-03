
import 'package:bloc/bloc.dart';
import 'package:experts_app/features/homeAdvisor/recycle_pin/manager/states.dart';

import '../../../../core/Services/web_services.dart';
import '../../../../data/dataSource/admin/Patients/allPatientAdmin/recycle/allPatients_admin_data_source_imp.dart';
import '../../../../data/dataSource/admin/Patients/allPatientAdmin/recycle/all_patients_admin_data_source.dart';
import '../../../../data/dataSource/allPatient/recycle/allPatients_data_source_imp.dart';
import '../../../../data/dataSource/allPatient/recycle/all_patients_data_source.dart';
import '../../../../data/repository_imp/all_patient_recycle_with_admin_repository_imp.dart';
import '../../../../data/repository_imp/all_patient_recycle_repository_imp.dart';
import '../../../../domain/entities/AllPatientModel.dart';
import '../../../../domain/repository/AllPatient/all_patient_recycle_repository.dart';
import '../../../../domain/repository/admin repository/all_patient_recycle_with_admin_repository.dart';
import '../../../../domain/useCase/adminUseCase/patiens/allpatient/all_patient_recycle_use_case.dart';
import '../../../../domain/useCase/allpatient/all_patient_recycle_use_case.dart';



class AllPatientRecycleCubit extends Cubit<AllPatientRecycleStates> {
  AllPatientRecycleCubit() : super(LoadingAllPatientRecycle());

  late AllPatientRecycleUseCase allPatientRecycleUseCase;
  late AllPatientRecycleRepository allPatientRecycleRepository;
  late AllPatientsRecycleDataSource allPatientRecycleDataSource;

  Future<void> getAllPatientRecycle(int recycle) async {
    WebServices service = WebServices();
    allPatientRecycleDataSource = AllPatientRecycleDataSourceImp(service.freeDio);
    allPatientRecycleRepository = AllPatientRecycleRepositoryImp(allPatientRecycleDataSource);
    allPatientRecycleUseCase = AllPatientRecycleUseCase(allPatientRecycleRepository);
    emit(LoadingAllPatientRecycle());
    try {
      var result = await allPatientRecycleUseCase.execute(
        AllPatientModel(),
         recycle
      );
      print('API Response: ${result.data}');

      final data = AllPatientModel.fromJson(result.data);
      emit(SuccessAllPatientRecycle(data.pationts ?? []));
    } catch (error) {
      emit(ErrorAllPatientRecycle(error.toString()));
    }
  }



  late AllPatientRecycleWithAdminUseCase allPatientRecycleWithAdminUseCase;
  late AllPatientRecycleWithAdminRepository allPatientRecycleAdminRepository;
  late AllPatientsRecycleWithAdminDataSource allPatientRecycleWithAdminDataSource;

  Future<void> getAllPatientRecycleWithAdmin(int recycle) async {
    WebServices service = WebServices();
    allPatientRecycleWithAdminDataSource = AllPatientRecycleWithAdminDataSourceImp(service.freeDio);
    allPatientRecycleAdminRepository = AllPatientRecycleWithAdminRepositoryImp(allPatientRecycleWithAdminDataSource);
    allPatientRecycleWithAdminUseCase = AllPatientRecycleWithAdminUseCase(allPatientRecycleAdminRepository);
    emit(LoadingAllPatientRecycle());
    try {
      var result = await allPatientRecycleWithAdminUseCase.execute(
          AllPatientModel(),
          recycle
      );
      print('API Response: ${result.data}');

      final data = AllPatientModel.fromJson(result.data);
      emit(SuccessAllPatientRecycle(data.pationts ?? []));
    } catch (error) {
      emit(ErrorAllPatientRecycle(error.toString()));
    }
  }





}
