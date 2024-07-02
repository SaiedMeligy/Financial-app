import 'package:bloc/bloc.dart';
import 'package:experts_app/features/homeAdmin/add_patient/manager/states.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/Failure/server_failure.dart';
import '../../../../core/Services/snack_bar_service.dart';
import '../../../../core/Services/web_services.dart';
import '../../../../data/dataSource/admin/Patients/registerPationtAdmin/register_pationt_admin_data_source.dart';
import '../../../../data/dataSource/admin/Patients/registerPationtAdmin/register_pationt_admin_data_source_imp.dart';
import '../../../../data/repository_imp/admin_repository_imp/patients/register_patient_repository_imp.dart';
import '../../../../domain/entities/RegisterPatient.dart';
import '../../../../domain/repository/admin repository/patiens/registerPatientWithAdmin/repository_register_patient_admin.dart';
import '../../../../domain/useCase/adminUseCase/patiens/registerPatient/register_patient_use_Case.dart';


class RegisterPatientWithAdminCubit extends Cubit<RegisterPatientWithAdminState>{
  RegisterPatientWithAdminCubit() : super(LoadingRegisterPatientWithAdminState());
  late RegisterPatientWithAdminUseCase registerUseCase;
  late RepositoryRegisterPatientWithAdmin repositoryRegisterPatientWithAdmin;
  late RegisterPatientWithAdminDataSource registerDataSource;
  Future <bool> registerUser(RegisterPatientDataRequest data) async{
    //EasyLoading.show();
    emit(LoadingRegisterPatientWithAdminState());
    WebServices service = WebServices();
    registerDataSource = RegisterPatientWithAdminDatasourceImp(dio:service.freeDio);
    repositoryRegisterPatientWithAdmin = RegisterPatientWithAdminRepositoryImp(registerDataSource);
    registerUseCase = RegisterPatientWithAdminUseCase(repositoryRegisterPatientWithAdmin);
    EasyLoading.show();
    final result = await registerUseCase.execute(data);

    //EasyLoading.dismiss();
   return result.fold((fail) {
     var error = fail as ServerFailure;
     EasyLoading.dismiss();
     SnackBarService.showErrorMessage(error.message??"fail to register");
     emit(ErrorRegisterPatientWithAdminState( error.toString()));
     return Future.value(false);
   }, (data) {
     EasyLoading.dismiss();
     //emit(SuccessRegisterPatientWithAdminState());
     return Future.value(true);

   }
   );
  }
}