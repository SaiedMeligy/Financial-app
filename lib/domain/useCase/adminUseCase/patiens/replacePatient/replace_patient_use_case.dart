import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../../../repository/admin repository/patiens/replacePatient/replace_patient_repository.dart';




class ReplacePatientWithAdminUseCase{
  final ReplacePatientWithAdminRepository replacePatientRepository;
  ReplacePatientWithAdminUseCase(this.replacePatientRepository);

  Future<Response> execute(int id,int advisorId)async{

    return await replacePatientRepository.replacePatientWithAdmin(id,advisorId);
  }
}