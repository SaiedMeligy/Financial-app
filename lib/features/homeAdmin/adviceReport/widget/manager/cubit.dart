// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:experts_app/domain/entities/PointerReportModel.dart';
// import 'package:experts_app/features/homeAdmin/pointerReport/widget/manager/states.dart';
//
// import '../../../../../core/Services/web_services.dart';
// import '../../../../../data/dataSource/PointerReport/pointer_report_data_source.dart';
// import '../../../../../data/dataSource/PointerReport/pointer_report_data_source_imp.dart';
// import '../../../../../data/repository_imp/pointer_report_repository_imp.dart';
// import '../../../../../domain/repository/PointerReport/pointer_report_repository.dart';
// import '../../../../../domain/useCase/PointerReport/pointer_report_use_case.dart';
// import '../../../../homeAdvisor/viewQuestion/manager/states.dart';
//
// class LineChartCubit extends Cubit<LineChartStates>{
//   LineChartCubit() : super(LoadingLineChartState());
//   late PointerReportUseCase addQuestionUseCase;
//   late PointerReportRepository addQuestionRepository;
//   late PointerReportDataSource dataSource;
//
//   Future<void> getPointerReport(PointerReportModel pointer,int id) async {
//     WebServices service = WebServices();
//     dataSource = PointerReportDataSourceImp(service.freeDio);
//     addQuestionRepository = PointerReportRepositoryImp(dataSource);
//     addQuestionUseCase = PointerReportUseCase(addQuestionRepository);
//     try {
//       final result = await addQuestionUseCase.execute(pointer, id);
//       final data = PointerReportModel.fromJson(result.data);
//
//
//       emit(SuccessLineChartState(data.report!));
//     }
//     catch (e) {
//       emit(ErrorLineChartState(e.toString()));
//     }
//   }
//
// }