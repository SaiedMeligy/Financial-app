import 'package:dio/dio.dart';

import '../../repository/deletePatient/delete_patient_repository.dart';


class DeletePatientUseCase{
  final DeletePatientRepository deletePatientRepository;
  DeletePatientUseCase(this.deletePatientRepository);

  Future<Response> execute(int id)async{

    return await deletePatientRepository.deletePatient(id);
  }
}