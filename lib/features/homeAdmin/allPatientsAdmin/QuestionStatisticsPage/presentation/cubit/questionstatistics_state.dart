part of 'questionstatistics_cubit.dart';

@immutable
sealed class QuestionstatisticsState {}

final class QuestionstatisticsInitial extends QuestionstatisticsState {}
final class QuestionstatisticsLoading extends QuestionstatisticsState {}
final class QuestionstatisticsError extends QuestionstatisticsState {
  String message ;
  QuestionstatisticsError(this.message);
}
final class QuestionstatisticsLoaded extends QuestionstatisticsState {
  QuestionStatisticsModel QuestionStatistics ;
  QuestionstatisticsLoaded(this.QuestionStatistics) ;
}
