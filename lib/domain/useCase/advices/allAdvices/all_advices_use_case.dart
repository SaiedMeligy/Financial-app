import 'package:dio/dio.dart';
import '../../../entities/AdviceMode.dart';
import '../../../repository/advices/AllAdvices/all_advices_repository.dart';

class AllAdvicesUseCase{

  final AllAdvicesRepository allAdvicesRepository;

  AllAdvicesUseCase( this.allAdvicesRepository);

  Future<Response> execute(AdviceModel adviceModel){
    return allAdvicesRepository.getAllAdvices(adviceModel);
  }
}