import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

abstract class AllPatientRecycleRepository{
  Future<Response> getAllPatientRecycle(AllPatientModel patientModel,int recycle,{int page =1,int per_page =20});
}