import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/widget/manager/states.dart';

import '../../../../../core/Services/web_services.dart';
import '../../../../../data/dataSource/admin/form/patientFormView/patient_form_view_admin_data_source.dart';
import '../../../../../data/dataSource/admin/form/patientFormView/patient_form_view_admin_data_source_imp.dart';
import '../../../../../data/repository_imp/admin_repository_imp/form/patient_form_view_admin_repository_imp.dart';
import '../../../../../domain/repository/admin repository/form/patientFormViewRepository/patient_form_view_repository.dart';
import '../../../../../domain/useCase/adminUseCase/form/patientFormViewAdmin/patient_form_view_admin_use_case.dart';

class PatientFormViewWithAdminCubit extends Cubit<PatientFormViewWithAdminStates>{
  PatientFormViewWithAdminCubit() : super(LoadingPatientFormViewWithAdminState());

  late PatientFormViewWithAdminUseCase patientFormViewUseCase;
  late PatientFormViewWithAdminRepository patientFormViewRepository;
  late PatientFormViewWithAdminDataSource patientFormViewDataSource;

  Future<Response> getPatientFormViewWithAdmin(int patientId) async {
    WebServices service = WebServices();
    patientFormViewDataSource = PatientFormViewWithAdminDataSourceImp(service.freeDio);
    patientFormViewRepository = PatientFormViewWithAdminRepositoryImp(patientFormViewDataSource);
    patientFormViewUseCase = PatientFormViewWithAdminUseCase(patientFormViewRepository);



     var result = await patientFormViewUseCase.execute(patientId);
    emit(SuccessPatientFormViewWithAdminState(result));
    return result;
  }


}