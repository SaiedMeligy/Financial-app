import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/domain/entities/PointerReportModel.dart';
import '../../domain/repository/PointerReport/pointer_report_repository.dart';
import '../dataSource/PointerReport/pointer_report_data_source.dart';
class PointerReportRepositoryImp implements PointerReportRepository{
  final PointerReportDataSource dataSource;
  PointerReportRepositoryImp(this.dataSource);
  @override
  Future<Response> getPointerReport(Report pointer,int id) async {
    try {
      final response = await dataSource.getPointerReport(pointer,id);
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