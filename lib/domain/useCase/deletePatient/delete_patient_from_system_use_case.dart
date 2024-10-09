import 'package:dio/dio.dart';

import '../../repository/deletePatient/delete_patient_from_system_repository.dart';


class DeletePatientFromSystemUseCase{
  final DeletePatientFromSystemRepository deletePatientRepository;
  DeletePatientFromSystemUseCase(this.deletePatientRepository);

  Future<Response> execute(int id)async{

    return await deletePatientRepository.deletePatient(id);
  }
}