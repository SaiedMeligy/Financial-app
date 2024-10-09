import 'package:dio/dio.dart';

import '../../../../repository/admin repository/patiens/deletePatientFromSystemWithAdmin/delete_patient_from_system_with_admin_repository.dart';


class DeletePatientFromSystemWithAdminUseCase{
  final DeletePatientFromSystemWithAdminRepository deletePatientRepository;
  DeletePatientFromSystemWithAdminUseCase(this.deletePatientRepository);

  Future<Response> execute(int id)async{

    return await deletePatientRepository.deletePatientWithAdmin(id);
  }
}