import 'package:bloc/bloc.dart';
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
  int currentPage = 1;
  bool isLoading = false;
  bool isLastPage = false;
  String currentSearchQuery = '';
  List<Sessions> sessions = [];
  List<Sessions> sessionsAdvicors = [];
  AllSessionCubit() : super(LoadingAllSession());

  late AllSessionUseCase allSessionUseCase;
  late AllSessionRepository allSessionRepository;
  late AllSessionDataSource allSessionDataSource;

  Future<void> getAllSession({bool loadMore = false}) async {
    if (isLastPage || isLoading) return;

    isLoading = true;
    WebServices service = WebServices();
    allSessionDataSource = AllSessionDataSourceImp(service.freeDio);
    allSessionRepository = AllSessionRepositoryImp(allSessionDataSource);
    allSessionUseCase = AllSessionUseCase(allSessionRepository);
    if (!loadMore) emit(LoadingAllSession());
    try {
      var result =
          await allSessionUseCase.execute(AllSessionModel(), page: currentPage);
      final data = AllSessionModel.fromJson(result.data);
      if (data.sessions!.isEmpty) {
        isLastPage = true;
      } else {
        currentPage++;
        sessionsAdvicors.addAll(data.sessions ?? []);
      }
      emit(SuccessAllSession(sessionsAdvicors));
    } catch (error) {
      emit(ErrorAllSession(error.toString()));
    } finally {
      isLoading = false;
    }
  }

  late AllSessionWithAdminUseCase allSessionWithAdminUseCase;
  late AllSessionWithAdminRepository allSessionWithAdminRepository;
  late AllSessionWithAdminDataSource allSessionWithAdminDataSource;

  Future<void> getAllSessionWithAdmin(
      {bool loadMore = true, String? searchQuery}) async {
    if (searchQuery != null && !loadMore) {
      if (searchQuery == currentSearchQuery) return;
      isLastPage = false;
      currentPage = 1;
      currentSearchQuery = searchQuery;
      sessions = [];
    }
    if (isLastPage || isLoading) return;

    isLoading = true;
    WebServices service = WebServices();
    allSessionWithAdminDataSource =
        AllSessionWithAdminDataSourceImp(service.freeDio);
    allSessionWithAdminRepository =
        AllSessionWithAdminRepositoryImp(allSessionWithAdminDataSource);
    allSessionWithAdminUseCase =
        AllSessionWithAdminUseCase(allSessionWithAdminRepository);
    if (!loadMore) emit(LoadingAllSession());
    try {
      var result = await allSessionWithAdminUseCase.execute(AllSessionModel(),
          page: currentPage, searchQuery: currentSearchQuery);
      final data = AllSessionModel.fromJson(result.data);
      if (data.sessions!.isEmpty) {
        isLastPage = true;
      } else {
        currentPage++;
        sessions.addAll(data.sessions ?? []);
      }
      emit(SuccessAllSession(sessions));
    } catch (error) {
      emit(ErrorAllSession(error.toString()));
    } finally {
      isLoading = false;
    }
  }
}
