import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/data/repository_imp/delete_consultation_repository_imp.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../../../../../../core/Services/web_services.dart';
import '../../../../../data/dataSource/allPatient/deletePatient/delete_patient_data_source.dart';
import '../../../../../data/dataSource/allPatient/deletePatient/delete_patient_data_source_imp.dart';
import '../../../../../data/dataSource/allPatient/updatepatient/update_patient_data_source.dart';
import '../../../../../data/dataSource/allPatient/updatepatient/update_patient_data_source_imp.dart';
import '../../../../../data/repository_imp/delete_Patient_repository_imp.dart';
import '../../../../../data/repository_imp/update_patient_repository_imp.dart';
import '../../../../../domain/repository/deletePatient/delete_patient_repository.dart';
import '../../../../../domain/updatePatient/update_patient_repository.dart';
import '../../../../../domain/useCase/deletePatient/delete_patient_use_case.dart';
import '../../../../../domain/useCase/updatePatient/update_patient_use_case.dart';
import 'dialog_state.dart';

class UpdatePatientCubit extends Cubit<UpdatePatientStates>{
  UpdatePatientCubit() : super(LoadingUpdatePatientState());
  late UpdatePatientUseCase updatePatientUseCase;
  late UpdatePatientRepository updatePatientRepository;
  late UpdatePatientDataSource updatePatientDataSource;

  Future<void> updatePatient(int id ,Pationts patient) async {
    WebServices service = WebServices();
    updatePatientDataSource =
        UpdatePatientDataSourceImp(service.freeDio);
    updatePatientRepository =
        UpdatePatientRepositoryImp(updatePatientDataSource);
    updatePatientUseCase =
        UpdatePatientUseCase(updatePatientRepository);
    emit(LoadingUpdatePatientState());

    try {
      final response = await updatePatientUseCase.execute(id, patient);

      emit(SuccessUpdatePatientState(response.data));
    } catch (error) {
      emit(ErrorUpdatePatients(error.toString()));
    }
  }

  late DeletePatientUseCase deletePatientUseCase;
  late DeletePatientRepository deletePatientRepository;
  late DeletePatientDataSource deletePatientDataSource;

  Future<void> deletePatient(int id ) async {
    WebServices service = WebServices();
    deletePatientDataSource =
        DeletePatientDataSourceImp(service.freeDio);
    deletePatientRepository =
        DeletePatientRepositoryImp(deletePatientDataSource);
    deletePatientUseCase =
        DeletePatientUseCase(deletePatientRepository);
    emit(LoadingUpdatePatientState());

    try {
      final response = await deletePatientUseCase.execute(id);

      emit(SuccessDeletePatientState(response.data));
    } catch (error) {
      emit(ErrorUpdatePatients(error.toString()));
    }
  }


  }