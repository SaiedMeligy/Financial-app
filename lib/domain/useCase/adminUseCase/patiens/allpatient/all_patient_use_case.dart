import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../../../repository/admin repository/patiens/AllPatientWithAdmin/all_patient_repository.dart';


class AllPatientWithAdminUseCase{

  final AllPatientWithAdminRepository allPatientRepository;

  AllPatientWithAdminUseCase( this.allPatientRepository);

  Future<Response> execute(AllPatientModel patientModel,{int page =1,int per_page = 20, String searchQuery = ''}) async {
    return allPatientRepository.getAllPatientWithAdmin(patientModel,page: page,per_page: per_page,searchQuery : searchQuery);
  }
}