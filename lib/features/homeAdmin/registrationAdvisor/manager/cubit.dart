import 'package:bloc/bloc.dart';
import 'package:experts_app/features/homeAdmin/registrationAdvisor/manager/states.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/Failure/server_failure.dart';
import '../../../../core/Services/snack_bar_service.dart';
import '../../../../core/Services/web_services.dart';
import '../../../../data/dataSource/registerAdvisor/register_data_source.dart';
import '../../../../data/dataSource/registerAdvisor/register_data_source_imp.dart';
import '../../../../data/repository_imp/register_advisor_repository_imp.dart';
import '../../../../domain/entities/RegisterModel.dart';
import '../../../../domain/repository/registerAdvisor/repository_register.dart';
import '../../../../domain/useCase/registerAdvisor/register_use_Case.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(LoadingRegisterState());
  late RegisterUseCase registerUseCase;
  late RepositoryRegister repositoryRegister;
  late RegisterDataSource registerDataSource;
  Future <bool> registerUser(RegisterDataRequest data) async{
    //EasyLoading.show();
    emit(LoadingRegisterState());
    WebServices service = WebServices();
    registerDataSource = RegisterDatasourceImp(dio:service.freeDio);
    repositoryRegister = RegisterRepositoryImp(registerDataSource);
    registerUseCase = RegisterUseCase(repositoryRegister);
    EasyLoading.show();
    final result = await registerUseCase.execute(data);

    //EasyLoading.dismiss();
   return result.fold((fail) {
     var error = fail as ServerFailure;
     EasyLoading.dismiss();
     SnackBarService.showErrorMessage(error.message??"fail to register");
     emit(ErrorRegisterState( error.toString()));
     return Future.value(false);
   }, (data) {
     EasyLoading.dismiss();
     //emit(SuccessRegisterState());
     return Future.value(true);

   }
   );
  }
}