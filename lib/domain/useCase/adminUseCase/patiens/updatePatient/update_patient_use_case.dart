import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../../../repository/admin repository/patiens/updatePatient/update_patient_repository.dart';



class UpdatePatientWithAdminUseCase{
  final UpdatePatientWithAdminRepository updatePatientRepository;
  UpdatePatientWithAdminUseCase(this.updatePatientRepository);

  Future<Response> execute(int id,Pationts patient)async{

    return await updatePatientRepository.updatePatientWithAdmin(id,patient);
  }
}