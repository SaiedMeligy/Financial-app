import 'package:dio/dio.dart';
import '../../../repository/admin repository/deleteSessionWithAdmin/delete_session_with_admin_repository.dart';


class DeleteSessionWithAdminUseCase{
  final DeleteSessionWithAdminRepository deleteSessionWithAdminRepository;
  DeleteSessionWithAdminUseCase(this.deleteSessionWithAdminRepository);

  Future<Response> execute(int id)async{

    return await deleteSessionWithAdminRepository.deleteSessionWithAdmin(id);
  }
}