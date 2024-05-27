
import '../../../../../domain/entities/PointerReportModel.dart';


abstract class LineChartStates{}
class LoadingLineChartState extends LineChartStates{}
class SuccessLineChartState extends LineChartStates{
  final List<Report> report;
  SuccessLineChartState(this.report);

}
class ErrorLineChartState extends LineChartStates{
  final String errorMessage;
  ErrorLineChartState(this.errorMessage);
}