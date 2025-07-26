import 'package:dartz/dartz.dart';
import 'package:experts_app/core/Failure/failure.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/data/datasource/QuestionStatisticsDatasource.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/data/models/QuestionStatisticsModel.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/domain/repositories/QuestionStatisticsRepository.dart';

class Questionstatisticsrepositoryimpl implements QuestionStatisticsRepository{
  Questionstatisticsdatasource datasource ;
  Questionstatisticsrepositoryimpl(this.datasource);

  Future<Either<Failure , QuestionStatisticsModel>> getQuestionStatistics(String text) => datasource.getQuestionStatistics(text) ;
}