
import 'package:bloc/bloc.dart';
import 'package:experts_app/data/dataSource/adviceReport/advice_report_data_source.dart';
import 'package:experts_app/features/homeAdmin/adviceReport/widget/manager/states.dart';

import '../../../../../core/Services/web_services.dart';
import '../../../../../data/dataSource/adviceReport/advice_report_data_source_imp.dart';
import '../../../../../data/repository_imp/advice_report_repository_imp.dart';
import '../../../../../domain/entities/AdviceReportModel.dart';
import '../../../../../domain/repository/AdviceReport/advice_report_repository.dart';
import '../../../../../domain/useCase/adviceReport/advice_report_use_case.dart';

class LineChartAdviceCubit extends Cubit<LineChartAdviceStates>{
  LineChartAdviceCubit() : super(LoadingLineChartAdviceState());
  late AdviceReportUseCase adviceUseCase;
  late AdviceReportRepository adviceRepository;
  late AdviceReportDataSource dataSourceAdvice;
  Future<void> getAdviceReport(ReportAdvice advice) async {
    WebServices service = WebServices();
    dataSourceAdvice = AdviceReportDataSourceImp(service.freeDio);
    adviceRepository = AdviceReportRepositoryImp(dataSourceAdvice);
    adviceUseCase = AdviceReportUseCase(adviceRepository);


    try {
      final result = await adviceUseCase.execute(advice);
      print('API Response: ${result.data}'); // Add this line for debugging
      final data = AdviceReportModel.fromJson(result.data);
      emit(SuccessLineChartAdviceState(data.advice!));
    }
    catch (e) {
      print("Error:$e");
      emit(ErrorLineChartAdviceState(e.toString()));
    }
  }

}