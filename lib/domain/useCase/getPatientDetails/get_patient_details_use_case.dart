import 'package:dio/dio.dart';

import '../../repository/getPatientDetailsRepository/get_patient_details_repository.dart';

class GetPatientDetailsUseCase {
  final GetPatientDetailsRepository getPatientDetailsRepository;
  GetPatientDetailsUseCase(this.getPatientDetailsRepository);
  Future<Response> execute(String nationalId)async{
    return await getPatientDetailsRepository.getPatientDetails(nationalId);
  }
  }