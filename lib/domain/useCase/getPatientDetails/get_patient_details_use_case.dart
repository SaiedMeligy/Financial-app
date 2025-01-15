import 'package:dio/dio.dart';

import '../../repository/getPatientDetailsRepository/get_patient_details_repository.dart';

class GetPatientDetailsUseCase {
  final GetPatientDetailsRepository getPatientDetailsRepository;
  GetPatientDetailsUseCase(this.getPatientDetailsRepository);
  Future<Response> execute(String nationalId,int? with_all_questions)async{
    return await getPatientDetailsRepository.getPatientDetails(nationalId,with_all_questions);
  }
  }