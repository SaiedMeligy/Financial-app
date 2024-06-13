import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';

import '../../../../core/Services/web_services.dart';
import '../../../../data/dataSource/getPatientDetails/get_patient_details_data_source.dart';
import '../../../../data/dataSource/getPatientDetails/get_patient_details_data_source_imp.dart';
import '../../../../data/repository_imp/get_patient_details_repository_imp.dart';
import '../../../../domain/repository/getPatientDetailsRepository/get_patient_details_repository.dart';
import '../../../../domain/useCase/getPatientDetails/get_patient_details_use_case.dart';

class AddSessionCubit extends Cubit<AddSessionStates> {
  AddSessionCubit() : super(LoadingAddSessionState());


  late GetPatientDetailsUseCase getPatientDetailsUseCase;
  late GetPatientDetailsRepository getPatientDetailsRepository;
  late GetPatientDetailsDataSource getPatientDetailsDataSource;

  Future<void> getPatientDetails(String nationalId) async {
    WebServices service = WebServices();
    getPatientDetailsDataSource = GetPatientDetailsDataSourceImp(service.freeDio);
    getPatientDetailsRepository = GetPatientDetailsRepositoryImp(getPatientDetailsDataSource);
    getPatientDetailsUseCase = GetPatientDetailsUseCase(getPatientDetailsRepository);
    emit(LoadingAddSessionState());
    try {
      final patientDetails = await getPatientDetailsUseCase.execute(nationalId);
      emit(SuccessPatientNationalIdState(patientDetails));
    }
    catch (e) {
      emit(ErrorAddSessionState(e.toString()));
    }
  }

}
