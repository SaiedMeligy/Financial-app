import 'package:dio/dio.dart';

import '../../../repository/advices/addAdvice/add_advice_repository.dart';


class AddAdviceUseCase{
  final AddAdviceRepository adviceRepository;
  AddAdviceUseCase(this.adviceRepository);
  Future<Response> execute(String advice)async{
    return await adviceRepository.addAdvice(advice);
  }
}