
import 'package:experts_app/domain/entities/AdviceReportModel.dart';



abstract class LineChartAdviceStates{}
class LoadingLineChartAdviceState extends LineChartAdviceStates{}
class SuccessLineChartAdviceState extends LineChartAdviceStates{
  final List<ReportAdvice> advice;
  SuccessLineChartAdviceState(this.advice);

}
class ErrorLineChartAdviceState extends LineChartAdviceStates{
  final String errorMessage;
  ErrorLineChartAdviceState(this. errorMessage);
}