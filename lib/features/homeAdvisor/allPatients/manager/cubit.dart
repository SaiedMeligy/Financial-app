import 'package:bloc/bloc.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/manager/states.dart';
import '../../../../data/dataSource/allPatient/allPatients_data_source_imp.dart';
import '../../../../data/dataSource/allPatient/all_patients_data_source.dart';
import '../../../../data/repository_imp/all_patient_repository_imp.dart';
import '../../../../domain/repository/AllPatient/all_patient_repository.dart';
import '../../../../domain/useCase/allpatient/all_patient_use_case.dart';

class AllPatientCubit extends Cubit<AllPatientStates> {
  AllPatientCubit() : super(LoadingAllPatient());

  late AllPatientUseCase allPatientUseCase;
  late AllPatientRepository allPatientRepository;
  late AllPatientsDataSource allPatientDataSource;

  Future<void> getAllPatient() async {
    WebServices service = WebServices();
    allPatientDataSource = AllPatientDataSourceImp(service.freeDio);
    allPatientRepository = AllPatientRepositoryImp(allPatientDataSource);
    allPatientUseCase = AllPatientUseCase(allPatientRepository);
    emit(LoadingAllPatient());
    try {
      var result = await allPatientUseCase.execute(AllPatientModel());
      print('API Response: ${result.data}');

      final data = AllPatientModel.fromJson(result.data);
      emit(SuccessAllPatient(data.pationts ?? []));
    } catch (error) {
      emit(ErrorAllPatient(error.toString()));
    }
  }
}
