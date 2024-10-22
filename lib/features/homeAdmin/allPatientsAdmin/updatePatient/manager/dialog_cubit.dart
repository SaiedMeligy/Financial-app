import 'package:bloc/bloc.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../../../../../../core/Services/web_services.dart';
import '../../../../../data/dataSource/admin/Patients/allPatientAdmin/deletePatient/delete_patient_admin_data_source.dart';
import '../../../../../data/dataSource/admin/Patients/allPatientAdmin/deletePatient/delete_patient_admin_data_source_imp.dart';
import '../../../../../data/dataSource/admin/Patients/allPatientAdmin/deletePatientFromSystemWithAdmin/delete_patient_from_system_admin_data_source.dart';
import '../../../../../data/dataSource/admin/Patients/allPatientAdmin/deletePatientFromSystemWithAdmin/delete_patient_from_system_admin_data_source_imp.dart';
import '../../../../../data/dataSource/admin/Patients/allPatientAdmin/updatepatient/update_patient_data_source.dart';
import '../../../../../data/dataSource/admin/Patients/allPatientAdmin/updatepatient/update_patient_data_source_imp.dart';
import '../../../../../data/repository_imp/admin_repository_imp/patients/delete_Patient_from_system_with_admin_repository_imp.dart';
import '../../../../../data/repository_imp/admin_repository_imp/patients/delete_Patient_repository_imp.dart';
import '../../../../../data/repository_imp/admin_repository_imp/patients/update_patient_repository_imp.dart';
import '../../../../../domain/repository/admin repository/patiens/deletePatient/delete_patient_repository.dart';
import '../../../../../domain/repository/admin repository/patiens/deletePatientFromSystemWithAdmin/delete_patient_from_system_with_admin_repository.dart';
import '../../../../../domain/repository/admin repository/patiens/updatePatient/update_patient_repository.dart';
import '../../../../../domain/useCase/adminUseCase/patiens/deletePatient/delete_patient_use_case.dart';
import '../../../../../domain/useCase/adminUseCase/patiens/deletePatientFromSystem/delete_patient_from_system_use_case.dart';
import '../../../../../domain/useCase/adminUseCase/patiens/updatePatient/update_patient_use_case.dart';
import 'dialog_state.dart';

class UpdatePatientWithAdminCubit extends Cubit<UpdatePatientWithAdminStates>{
  UpdatePatientWithAdminCubit() : super(LoadingUpdatePatientWithAdminState());
  late UpdatePatientWithAdminUseCase updatePatientUseCase;
  late UpdatePatientWithAdminRepository updatePatientRepository;
  late UpdatePatientWithAdminDataSource updatePatientDataSource;

  Future<void> updatePatientWithAdmin(int id ,Pationts patient) async {
    WebServices service = WebServices();
    updatePatientDataSource =
        UpdatePatientWithAdminDataSourceImp(service.freeDio);
    updatePatientRepository =
        UpdatePatientWithAdminRepositoryImp(updatePatientDataSource);
    updatePatientUseCase =
        UpdatePatientWithAdminUseCase(updatePatientRepository);
    emit(LoadingUpdatePatientWithAdminState());

    try {
      final response = await updatePatientUseCase.execute(id, patient);

      emit(SuccessUpdatePatientWithAdminState(response.data));
    } catch (error) {
      emit(ErrorUpdatePatientWithAdmin(error.toString()));
    }
  }

  late DeletePatientWithAdminUseCase deletePatientUseCase;
  late DeletePatientWithAdminRepository deletePatientRepository;
  late DeletePatientWithAdminDataSource deletePatientDataSource;

  Future<void> deletePatient(int id ) async {
    WebServices service = WebServices();
    deletePatientDataSource =
        DeletePatientWithAdminDataSourceImp(service.freeDio);
    deletePatientRepository =
        DeletePatientWithAdminRepositoryImp(deletePatientDataSource);
    deletePatientUseCase =
        DeletePatientWithAdminUseCase(deletePatientRepository);
    emit(LoadingUpdatePatientWithAdminState());

    try {
      final response = await deletePatientUseCase.execute(id);

      emit(SuccessDeletePatientWithAdminState(response.data));
    } catch (error) {
      emit(ErrorUpdatePatientWithAdmin(error.toString()));
    }
  }

  late DeletePatientFromSystemWithAdminUseCase deletePatientFromSystemUseCase;
  late DeletePatientFromSystemWithAdminRepository deletePatientFromSystemRepository;
  late DeletePatientFromSystemWithAdminDataSource deletePatientFromSystemDataSource;

  Future<void> deletePatientFromSystem(int id ) async {
    WebServices service = WebServices();
    deletePatientFromSystemDataSource =
        DeletePatientFromSystemWithAdminDataSourceImp(service.freeDio);
    deletePatientFromSystemRepository =
        DeletePatientFromSystemWithAdminRepositoryImp(deletePatientFromSystemDataSource);
    deletePatientFromSystemUseCase =
        DeletePatientFromSystemWithAdminUseCase(deletePatientFromSystemRepository);
    emit(LoadingUpdatePatientWithAdminState());

    try {
      final response = await deletePatientFromSystemUseCase.execute(id);

      emit(SuccessDeletePatientWithAdminState(response.data));
    } catch (error) {
      emit(ErrorUpdatePatientWithAdmin(error.toString()));
    }
  }





  }
