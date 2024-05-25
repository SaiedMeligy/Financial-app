import 'package:dio/dio.dart';
import '../../../repository/advices/deleteAdvice/delete_advice_repository.dart';


class DeleteAdviceUseCase{
  final DeleteAdviceRepository deleteAdviceRepository;
  DeleteAdviceUseCase(this.deleteAdviceRepository);

  Future<Response> execute(int id)async{

    return await deleteAdviceRepository.deleteAdvice(id);
  }
}