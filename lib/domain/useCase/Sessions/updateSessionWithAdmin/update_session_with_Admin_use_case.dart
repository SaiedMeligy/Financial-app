import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/SessionUpdateModel.dart';
import '../../../repository/sessions/updateSessionWithAdmin/update_session_with_Admin_repository.dart';



class UpdateSessionWithAdminUseCase{
  final UpdateSessionWithAdminRepository sessionRepository;
  UpdateSessionWithAdminUseCase(this.sessionRepository);
  Future<Response> execute(SessionsUpdateModel data)async{
    return await sessionRepository.updateSession(data);
  }
}