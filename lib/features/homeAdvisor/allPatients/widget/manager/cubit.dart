import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/widget/manager/states.dart';

import '../../../../../core/Services/web_services.dart';
import '../../../../../data/dataSource/Form/updateForm/update_form_data_source.dart';
import '../../../../../data/dataSource/Form/updateForm/update_form_data_source_imp.dart';
import '../../../../../data/dataSource/patientFormView/patient_form_view_data_source.dart';
import '../../../../../data/dataSource/patientFormView/patient_form_view_source_imp.dart';
import '../../../../../data/repository_imp/patient_form_view_repository_imp.dart';
import '../../../../../data/repository_imp/update_form_repository_imp.dart';
import '../../../../../domain/repository/FormRepository/updateForm/update_form_repository.dart';
import '../../../../../domain/repository/patientFormViewRepository/patient_form_view_repository.dart';
import '../../../../../domain/useCase/Form/updateForm/update_form_use_case.dart';
import '../../../../../domain/useCase/patientFormView/patient_form_view_use_case.dart';

class PatientFormViewCubit extends Cubit<PatientFormViewStates>{
  PatientFormViewCubit() : super(LoadingPatientFormViewState());

  late PatientFormViewUseCase patientFormViewUseCase;
  late PatientFormViewRepository patientFormViewRepository;
  late PatientFormViewDataSource patientFormViewDataSource;

  Future<Response> getPatientFormView(int patientId) async {
    WebServices service = WebServices();
    patientFormViewDataSource = PatientFormViewDataSourceImp(service.freeDio);
    patientFormViewRepository = PatientFormViewRepositoryImp(patientFormViewDataSource);
    patientFormViewUseCase = PatientFormViewUseCase(patientFormViewRepository);



     var result = await patientFormViewUseCase.execute(patientId);
    emit(SuccessPatientFormViewState(result));
    return result;
  }

  late UpdateFormUseCase updateFormUseCase;
  late UpdateFormRepository updateFormRepository;
  late UpdateFormDataSource updateFormDataSource;

  Future<Response> getUpdateForm(Map<String, dynamic> updateData) async {
    WebServices service = WebServices();
    updateFormDataSource = UpdateFormDataSourceImp(service.freeDio);
    updateFormRepository = UpdateFormRepositoryImp(updateFormDataSource);
    updateFormUseCase = UpdateFormUseCase(updateFormRepository);
    emit(LoadingPatientFormViewState());

    return await updateFormUseCase.execute(updateData);
  }


}