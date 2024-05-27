import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/PointerReportModel.dart';
import 'package:experts_app/domain/repository/PointerReport/pointer_report_repository.dart';

class PointerReportUseCase{
  final PointerReportRepository pointerReportRepository;
  PointerReportUseCase( this.pointerReportRepository);
  Future<Response> execute(PointerReportModel pointer,int id)async{
    return await pointerReportRepository.getPointerReport(pointer,id);
  }
}