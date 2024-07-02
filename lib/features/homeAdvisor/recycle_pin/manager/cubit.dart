import 'package:bloc/bloc.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/features/homeAdvisor/recycle_pin/manager/states.dart';

import '../../../../data/dataSource/allPatient/recycle/allPatients_data_source_imp.dart';
import '../../../../data/dataSource/allPatient/recycle/all_patients_data_source.dart';
import '../../../../data/repository_imp/all_patient_recycle_repository_imp.dart';
import '../../../../domain/entities/AllPatientModel.dart';
import '../../../../domain/repository/AllPatient/all_patient_recycle_repository.dart';
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
}
