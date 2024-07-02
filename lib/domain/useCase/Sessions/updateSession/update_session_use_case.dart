import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/SessionUpdateModel.dart';
import '../../../repository/sessions/updateSession/update_session_repository.dart';



class UpdateSessionUseCase{
  final UpdateSessionRepository sessionRepository;
  UpdateSessionUseCase(this.sessionRepository);
  Future<Response> execute(SessionsUpdateModel data)async{
    return await sessionRepository.updateSession(data);
  }
}