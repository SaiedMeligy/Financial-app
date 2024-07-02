import 'package:bloc/bloc.dart';
import 'package:experts_app/domain/entities/AddSessionModel.dart';
import 'package:experts_app/features/homeAdvisor/session%20dates/manager/states.dart';

import '../../../../core/Services/web_services.dart';
import '../../../../data/dataSource/AllSession/all_session_data_source.dart';
import '../../../../data/dataSource/AllSession/all_session_data_source_imp.dart';
import '../../../../data/dataSource/admin/AllSessionWithAdmin/all_session_with_admin_data_source.dart';
import '../../../../data/dataSource/admin/AllSessionWithAdmin/all_session_with_admin_data_source_imp.dart';
import '../../../../data/repository_imp/admin_repository_imp/all_session_with_admin_repository_imp.dart';
import '../../../../data/repository_imp/all_session_repository_imp.dart';
import '../../../../domain/entities/AllSessionModel.dart';
import '../../../../domain/repository/AllSession/all_session_repository.dart';
import '../../../../domain/repository/admin repository/AllSessionWithAdmin/all_session_with_admin_repository.dart';
import '../../../../domain/useCase/adminUseCase/allSessionWithAdmin/all_session_with_Admin_use_case.dart';
import '../../../../domain/useCase/allSession/all_session_use_case.dart';

class AllSessionCubit extends Cubit<AllSessionStates> {
  AllSessionCubit() : super(LoadingAllSession());

  late AllSessionUseCase allSessionUseCase;
  late AllSessionRepository allSessionRepository;
  late AllSessionDataSource allSessionDataSource;

  Future<void> getAllSession() async {
    WebServices service = WebServices();
    allSessionDataSource = AllSessionDataSourceImp(service.freeDio);
    allSessionRepository = AllSessionRepositoryImp(allSessionDataSource);
    allSessionUseCase = AllSessionUseCase(allSessionRepository);
    emit(LoadingAllSession());
    try {
      var result = await allSessionUseCase.execute(AllSessionModel());
      print('API Response: ${result.data}');

      final data = AllSessionModel.fromJson(result.data);
      if (data != null) {
        emit(SuccessAllSession(data.sessions ?? []));
      } else {
        emit(ErrorAllSession("No consultation services found"));
      }
    } catch (error) {
      emit(ErrorAllSession(error.toString()));
    }
  }

  late AllSessionWithAdminUseCase allSessionWithAdminUseCase;
  late AllSessionWithAdminRepository allSessionWithAdminRepository;
  late AllSessionWithAdminDataSource allSessionWithAdminDataSource;

  Future<void> getAllSessionWithAdmin() async {
    WebServices service = WebServices();
    allSessionWithAdminDataSource = AllSessionWithAdminDataSourceImp(service.freeDio);
    allSessionWithAdminRepository = AllSessionWithAdminRepositoryImp(allSessionWithAdminDataSource);
    allSessionWithAdminUseCase = AllSessionWithAdminUseCase(allSessionWithAdminRepository);
    emit(LoadingAllSession());
    try {
      var result = await allSessionWithAdminUseCase.execute(AllSessionModel());
      print('API Response: ${result.data}');

      final data = AllSessionModel.fromJson(result.data);
      if (data != null) {
        emit(SuccessAllSession(data.sessions ?? []));
      } else {
        emit(ErrorAllSession("No consultation services found"));
      }
    } catch (error) {
      emit(ErrorAllSession(error.toString()));
    }
  }
}
