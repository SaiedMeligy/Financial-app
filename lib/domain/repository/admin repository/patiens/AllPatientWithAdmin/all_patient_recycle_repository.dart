import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

abstract class AllPatientRecycleWithAdminRepository{
  Future<Response> getAllPatientRecycleWithAdmin(AllPatientModel patientModel,int recycle);
}