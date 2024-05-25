import 'package:bloc/bloc.dart';
import 'package:experts_app/features/homeAdmin/logout/manager/state.dart';
import '../../../../core/Failure/server_failure.dart';
import '../../../../core/Services/web_services.dart';
import '../../../../data/dataSource/logout/logout_data_source.dart';
import '../../../../data/dataSource/logout/logout_data_source_imp.dart';
import '../../../../data/repository_imp/logout_repository_imp.dart';
import '../../../../domain/repository/logout/logout_repository.dart';
import '../../../../domain/useCase/logout/logout_use_case.dart';

class LogoutCubit extends Cubit<LogoutStates>{
  LogoutCubit() : super( LoadingLogoutState());

  late LogoutUseCase logoutUseCase;
  late LogoutRepository logoutRepository;
  late LogoutDataSource logoutDataSource;

  Future<bool> logout()async{
    emit(LoadingLogoutState());
    WebServices service = WebServices();
    logoutDataSource = LogoutDataSourceImp(service.freeDio);
    logoutRepository = LogoutRepositoryImp(logoutDataSource);
    logoutUseCase = LogoutUseCase(logoutRepository);
    final result = await logoutUseCase.execute();
    print("Logout response: $result");
    return result.fold((fail) {
      var error = fail as ServerFailure;
      emit(ErrorLogoutState(error.toString()));
      return Future.value(false);

    }, (data) {
      print("Logout success data: $data");
      if (data == null) {
        emit(ErrorLogoutState("Logout data is null"));
        return Future.value(false);
      }
      emit(SuccessLogoutState());
      return Future.value(true);

    });

  }

}