import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllAdvisorsModel.dart';
import '../../../entities/AdviceMode.dart';
import '../../../repository/advisors/AllAdvisor/all_advisor_repository.dart';

class AllAdvisorUseCase{

  final AllAdvisorRepository allAdvisorRepository;

  AllAdvisorUseCase( this.allAdvisorRepository);

  Future<Response> execute(AllAdvisorsModel advisorModel){
    return allAdvisorRepository.getAllAdvisor(advisorModel);
  }
}