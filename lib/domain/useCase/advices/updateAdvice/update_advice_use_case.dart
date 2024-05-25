import 'package:dio/dio.dart';

import '../../../repository/advices/updateAdvice/update_advice_repository.dart';


class UpdateAdviceUseCase{
  final UpdateAdviceRepository updateAdviceRepository;
  UpdateAdviceUseCase(this.updateAdviceRepository);

  Future<Response> execute(int id,String title)async{

    return await updateAdviceRepository.updateAdvice(id,title);
  }
}