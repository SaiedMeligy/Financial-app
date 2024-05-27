import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:experts_app/features/homeAdmin/registrationAdvisor/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/add_user/manager/states.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/Failure/server_failure.dart';
import '../../../../core/Services/snack_bar_service.dart';
import '../../../../core/Services/web_services.dart';
import '../../../../data/dataSource/registerPationt/register_pationt_data_source.dart';
import '../../../../data/dataSource/registerPationt/register_pationt_data_source_imp.dart';
import '../../../../data/repository_imp/register_advisor_repository_imp.dart';
import '../../../../data/repository_imp/register_patient_repository_imp.dart';
import '../../../../domain/entities/RegisterPatient.dart';
import '../../../../domain/registerPatient/repository_register_patient.dart';
import '../../../../domain/useCase/registerPatient/register_patient_use_Case.dart';


class RegisterPatientCubit extends Cubit<RegisterPatientState>{
  RegisterPatientCubit() : super(LoadingRegisterPatientState());
  late RegisterPatientUseCase registerUseCase;
  late RepositoryRegisterPatient repositoryRegisterPatient;
  late RegisterPatientDataSource registerDataSource;
  Future <bool> registerUser(RegisterPatientDataRequest data) async{
    //EasyLoading.show();
    emit(LoadingRegisterPatientState());
    WebServices service = WebServices();
    registerDataSource = RegisterPatientDatasourceImp(dio:service.freeDio);
    repositoryRegisterPatient = RegisterPatientRepositoryImp(registerDataSource);
    registerUseCase = RegisterPatientUseCase(repositoryRegisterPatient);
    EasyLoading.show();
    final result = await registerUseCase.execute(data);

    //EasyLoading.dismiss();
   return result.fold((fail) {
     var error = fail as ServerFailure;
     EasyLoading.dismiss();
     SnackBarService.showErrorMessage(error.message??"fail to register");
     emit(ErrorRegisterPatientState( error.toString()));
     return Future.value(false);
   }, (data) {
     EasyLoading.dismiss();
     //emit(SuccessRegisterPatientState());
     return Future.value(true);

   }
   );
  }
}