
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../../../core/Services/web_services.dart';
import '../../../../../data/dataSource/admin/Patients/allPatientAdmin/Replacepatient/replace_patient_data_source.dart';
import '../../../../../data/dataSource/admin/Patients/allPatientAdmin/Replacepatient/replace_patient_data_source_imp.dart';
import '../../../../../data/repository_imp/admin_repository_imp/replace_patient_repository_imp.dart';
import '../../../../../domain/repository/admin repository/patiens/replacePatient/replace_patient_repository.dart';
import '../../../../../domain/useCase/adminUseCase/patiens/replacePatient/replace_patient_use_case.dart';
import 'state.dart';

class ReplacePatientWithAdminCubit extends Cubit<ReplacePatientWithAdminStates>{
  ReplacePatientWithAdminCubit() : super(LoadingReplacePatientWithAdminState());
  late ReplacePatientWithAdminUseCase replacePatientUseCase;
  late ReplacePatientWithAdminRepository replacePatientRepository;
  late ReplacePatientWithAdminDataSource replacePatientDataSource;

  Future<Response> replacePatientWithAdmin(int id ,int advisorId) async {
    WebServices service = WebServices();
    replacePatientDataSource =
        ReplacePatientWithAdminDataSourceImp(service.freeDio);
    replacePatientRepository =
        ReplacePatientRepositoryImp(replacePatientDataSource);
    replacePatientUseCase =
        ReplacePatientWithAdminUseCase(replacePatientRepository);
    emit(LoadingReplacePatientWithAdminState());
    return await replacePatientUseCase.execute(id, advisorId);


    // try {
    //   final response = await replacePatientUseCase.execute(id, advisorId);
    //
    //   emit(SuccessReplacePatientWithAdminState(response.data));
    // } catch (error) {
    //   emit(ErrorReplacePatientWithAdmin(error.toString()));
    // }
  }


  }