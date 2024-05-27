import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/domain/entities/AdviceReportModel.dart';

import '../../domain/repository/AdviceReport/advice_report_repository.dart';
import '../dataSource/adviceReport/advice_report_data_source.dart';

class AdviceReportRepositoryImp implements AdviceReportRepository{
  final AdviceReportDataSource dataSource;
  AdviceReportRepositoryImp(this.dataSource);
  @override
  Future<Response> getAdviceReport(AdviceReportModel advice) async {
    try {
      final response = await dataSource.getAdviceReport(advice);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response;
        }
        else {
          throw ServerFailure(statusCode: response.statusCode.toString(),
              message: response.data["message"] ?? "unKnown error"
          );
        }
      }
      else{
        throw ServerFailure(statusCode: response.statusCode.toString(),
            message: response.data["message"] ?? "unKnown error"
        );
      }
    }on DioException catch (dioException){
      throw ServerFailure(statusCode: dioException.response?.statusCode.toString()??"",
      message: dioException.response?.data["message"]?? "unKnown error");
    }
  }

}