import 'package:dio/dio.dart';

import '../../../../repository/admin repository/patiens/deletePatient/delete_patient_repository.dart';


class DeletePatientWithAdminUseCase{
  final DeletePatientWithAdminRepository deletePatientRepository;
  DeletePatientWithAdminUseCase(this.deletePatientRepository);

  Future<Response> execute(int id)async{

    return await deletePatientRepository.deletePatientWithAdmin(id);
  }
}