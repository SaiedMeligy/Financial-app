import 'package:bloc/bloc.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/data/dataSource/login/login_data_source_imp.dart';
import 'package:experts_app/data/repository_imp/login_repository_imp.dart';
import 'package:experts_app/domain/repository/login/login_repository.dart';
import 'package:experts_app/domain/useCase/login/login_use_case.dart';
import 'package:experts_app/features/login/manager/states.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/Services/snack_bar_service.dart';
import '../../../data/dataSource/login/login_data_source.dart';

 class LoginHomeCubit extends Cubit<HomeStates>{
    LoginHomeCubit() : super(LoginLoadingState());
  late LoginUseCase loginUseCase;
  late LoginRepository loginRepository;
  late LoginDataSource loginDataSource;

  Future<bool> login(String email, String password)async{
    EasyLoading.show();
    emit(LoginLoadingState());
    WebServices service = WebServices();
    loginDataSource = LoginDataSourceImp(service.freeDio);
    loginRepository = LoginRepositoryImp(loginDataSource);
    loginUseCase = LoginUseCase(loginRepository);
    EasyLoading.show();
    final result = await loginUseCase.execute(email, password);

     return result.fold((fail) {
      var error = fail as ServerFailure;
      EasyLoading.dismiss();
      SnackBarService.showErrorMessage(error.message ?? "خطأ في تسجيل الدخول");
      emit(LoginErrorState(error.toString()));
      return Future.value(false);

    }, (data) {
      EasyLoading.dismiss();
      emit(LoginSuccessState());
      return Future.value(true);
    }
    );

  }

}