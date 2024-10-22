

import 'package:dio/dio.dart';

import '../../../../entities/AllPatientModel.dart';
import '../../../../repository/admin repository/all_patient_recycle_with_admin_repository.dart';

class AllPatientRecycleWithAdminUseCase{

  final AllPatientRecycleWithAdminRepository allPatientRecycleWithAdminRepository;

  AllPatientRecycleWithAdminUseCase( this.allPatientRecycleWithAdminRepository);

  Future<Response> execute(AllPatientModel patientModel,int recycle,{int page =1,per_page=20}){
    return allPatientRecycleWithAdminRepository.getAllPatientRecycleWithAdmin(patientModel,recycle,page: page,per_page: per_page);
  }
}