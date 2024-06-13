import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AdviceReportModel.dart';

import '../../repository/AdviceReport/advice_report_repository.dart';

class AdviceReportUseCase{
  final AdviceReportRepository adviceReportRepository;
  AdviceReportUseCase( this.adviceReportRepository);
  Future<Response> execute(ReportAdvice advice)async{
    return await adviceReportRepository.getAdviceReport(advice);
  }
}