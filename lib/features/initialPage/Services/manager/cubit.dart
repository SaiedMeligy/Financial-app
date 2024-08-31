import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/data/dataSource/AddService/add_service_data_source.dart';
import 'package:experts_app/data/dataSource/AddService/add_service_data_source_imp.dart';
import 'package:experts_app/data/repository_imp/add_service_repository_imp.dart';
import 'package:experts_app/domain/repository/AddService/add_service_repository.dart';
import 'package:experts_app/domain/useCase/AddService/add_service_use_case.dart';
import 'package:experts_app/features/initialPage/Services/manager/states.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/Failure/server_failure.dart';
import '../../../../core/Services/snack_bar_service.dart';
import '../../../../data/dataSource/loginPatient/login_patient_data_source.dart';
import '../../../../data/dataSource/loginPatient/login_patient_data_source_imp.dart';
import '../../../../data/dataSource/reserveService/reserve_service_data_source.dart';
import '../../../../data/dataSource/reserveService/reserve_service_data_source_imp.dart';
import '../../../../data/repository_imp/login_patient_repository_imp.dart';
import '../../../../data/repository_imp/reserve_service_repository_imp.dart';
import '../../../../domain/repository/ReserveService/reserve_service_repository.dart';
import '../../../../domain/repository/loginPatient/login_patient_repository.dart';
import '../../../../domain/useCase/ReserveService/reserve_service_use_case.dart';
import '../../../../domain/useCase/loginPatient/login_patient_use_case.dart';

class AddServiceCubit extends Cubit<AddServiceStates>{
  AddServiceCubit(): super(LoadingAddService());
  late AddServiceUseCase addServiceUseCase;
  late AddServiceRepository addServiceRepository;
  late AddServiceDataSource addServiceDataSource;

  Future<Response> addService(String description)async{
    WebServices services = WebServices();
    addServiceDataSource = AddServiceDataSourceImp(services.freeDio);
    addServiceRepository = AddServiceRepositoryImp(addServiceDataSource);
    addServiceUseCase = AddServiceUseCase(addServiceRepository);
    final result = await addServiceUseCase.execute(description);
    return result;


  }

  late ReserveServiceUseCase reserveServiceUseCase;
  late ReserveServiceRepository reserveServiceRepository;
  late ReserveServiceDataSource reserveServiceDataSource;

  Future<Response> reserveService(int? consultationId,int patientId,String date,String time,int attending_type)async{
    WebServices services = WebServices();
    reserveServiceDataSource = ReserveServiceDataSourceImp(services.freeDio);
    reserveServiceRepository = ReserveServiceRepositoryImp(reserveServiceDataSource);
    reserveServiceUseCase = ReserveServiceUseCase(reserveServiceRepository);
    final result = await reserveServiceUseCase.execute(consultationId!,patientId,date,time,attending_type);
    return result;


  }

  late LoginPatientUseCase loginPatientUseCase;
  late LoginPatientRepository loginPatientRepository;
  late LoginPatientDataSource loginPatientDataSource;

  Future<bool> loginPatient(String nationalId)async{
    EasyLoading.show();
    emit(LoadingLoginStates());
    WebServices service = WebServices();
    loginPatientDataSource = LoginPatientDataSourceImp(service.freeDio);
    loginPatientRepository = LoginPatientRepositoryImp(loginPatientDataSource);
    loginPatientUseCase = LoginPatientUseCase(loginPatientRepository);
    EasyLoading.show();
    final result = await loginPatientUseCase.execute(nationalId);
    return result.fold((fail) {
      var error = fail as ServerFailure;
      EasyLoading.dismiss();
      SnackBarService.showErrorMessage(error.message ?? "خطأ في تسجيل الدخول");
      emit(ErrorLogin(error.toString()));
      return Future.value(false);

    }, (data) {
      //EasyLoading.dismiss();
      SnackBarService.showSuccessMessage("تم تسجيل الدخول بنجاح");
      emit(SuccessLoginStates());
      EasyLoading.dismiss();
      return Future.value(true);

    });

  }


}