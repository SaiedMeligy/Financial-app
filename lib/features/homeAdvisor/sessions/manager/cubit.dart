import 'package:bloc/bloc.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/data/dataSource/sessions/updateSession/update_session_data_source.dart';
import 'package:experts_app/data/dataSource/sessions/updateSession/update_session_data_source_imp.dart';
import 'package:experts_app/data/repository_imp/update_session_repository_imp.dart';
import 'package:experts_app/domain/entities/SessionUpdateModel.dart';
import 'package:experts_app/domain/repository/sessions/updateSession/update_session_repository.dart';
import 'package:experts_app/domain/useCase/Sessions/updateSession/update_session_use_case.dart';
import 'package:experts_app/features/homeAdvisor/sessions/manager/states.dart';

import '../../../../data/dataSource/sessions/updateSessionWithAdmin/update_session_with_admin_data_source.dart';
import '../../../../data/dataSource/sessions/updateSessionWithAdmin/update_session_with_admin_data_source_imp.dart';
import '../../../../data/repository_imp/admin_repository_imp/update_session_with_admin_repository_imp.dart';
import '../../../../domain/repository/sessions/updateSessionWithAdmin/update_session_with_Admin_repository.dart';
import '../../../../domain/useCase/Sessions/updateSessionWithAdmin/update_session_with_Admin_use_case.dart';

class UpdateSessionCubit extends Cubit<UpdateSessionStates> {
  UpdateSessionCubit() : super(LoadingUpdateSessionState());

  late UpdateSessionUseCase updateSessionUseCase;

  Future<Response> updateSession(SessionsUpdateModel data) async {
    emit(LoadingUpdateSessionState());

    WebServices services = WebServices();
    UpdateSessionDataSource updateSessionDataSource = UpdateSessionDataSourceImp(services.freeDio);
    UpdateSessionRepository updateRepository =
    UpdateSessionRepositoryImp(updateSessionDataSource);
    updateSessionUseCase = UpdateSessionUseCase(updateRepository);

    return await updateSessionUseCase.execute(data);
  }

  late UpdateSessionWithAdminUseCase updateSessionWithAdminUseCase;

  Future<Response> updateSessionWithAdmin(SessionsUpdateModel data) async {
    emit(LoadingUpdateSessionState());

    WebServices services = WebServices();
    UpdateSessionWithAdminDataSource updateSessionWithAdminDataSource = UpdateSessionWithAdminDataSourceImp(services.freeDio);
    UpdateSessionWithAdminRepository updateRepository = UpdateSessionWithAdminRepositoryImp(updateSessionWithAdminDataSource);
    updateSessionWithAdminUseCase = UpdateSessionWithAdminUseCase(updateRepository);

    return await updateSessionWithAdminUseCase.execute(data);
  }

}