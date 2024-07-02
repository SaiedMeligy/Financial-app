import 'package:dio/dio.dart';

import '../../../../repository/admin repository/patiens/getSessionDetailsRepository/get_session_details_repository.dart';


class GetSessionDetailsUseCase {
  final GetSessionDetailsRepository getSessionDetailsRepository;
  GetSessionDetailsUseCase(this.getSessionDetailsRepository);
  Future<Response> execute(String nationalId)async{
    return await getSessionDetailsRepository.getSessionDetails(nationalId);
  }
  }