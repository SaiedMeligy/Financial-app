import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../repository/updatePatient/update_patient_repository.dart';


class UpdatePatientUseCase{
  final UpdatePatientRepository updatePatientRepository;
  UpdatePatientUseCase(this.updatePatientRepository);

  Future<Response> execute(int id,Pationts patient)async{

    return await updatePatientRepository.updatePatient(id,patient);
  }
}