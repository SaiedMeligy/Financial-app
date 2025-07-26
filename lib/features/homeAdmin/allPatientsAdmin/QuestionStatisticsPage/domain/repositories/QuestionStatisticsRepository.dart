import 'package:dartz/dartz.dart';
import 'package:experts_app/core/Failure/failure.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/data/models/QuestionStatisticsModel.dart';

abstract class QuestionStatisticsRepository{
  Future<Either<Failure , QuestionStatisticsModel>> getQuestionStatistics(String text) ;
}