import 'package:dartz/dartz.dart';
import 'package:experts_app/core/Failure/failure.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/data/models/QuestionStatisticsModel.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/domain/repositories/QuestionStatisticsRepository.dart';

class GetQuestionStatisticsUsecase{
  QuestionStatisticsRepository repo ;
  GetQuestionStatisticsUsecase(this.repo) ;
  Future<Either<Failure , QuestionStatisticsModel>> call(String text) => repo.getQuestionStatistics(text) ;
}