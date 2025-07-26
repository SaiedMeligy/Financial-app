import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/data/datasource/QuestionStatisticsDatasourceImpl.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/data/models/QuestionStatisticsModel.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/data/repository/QuestionStatisticsRepositoryImpl.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/domain/usecases/GetQuestionStatisticsUsecase.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
part 'questionstatistics_state.dart';

class QuestionstatisticsCubit extends Cubit<QuestionstatisticsState> {
  final GetQuestionStatisticsUsecase _getQuestionStatistics;

  QuestionstatisticsCubit(): _getQuestionStatistics = GetQuestionStatisticsUsecase(
    Questionstatisticsrepositoryimpl(
      Questionstatisticsdatasourceimpl(Dio()),
    ),
  ), super(QuestionstatisticsInitial());

  Future<void> getQuestionStatistics(String text) async {
    emit(QuestionstatisticsLoading());
    final response = await _getQuestionStatistics(text);
    response.fold(
      (failure) {
        emit(QuestionstatisticsError("Error has occurred"));
      },
      (statistics) {
        emit(QuestionstatisticsLoaded(statistics));
      },
    );
  }
}
