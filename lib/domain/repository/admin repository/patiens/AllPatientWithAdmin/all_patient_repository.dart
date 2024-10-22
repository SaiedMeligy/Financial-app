import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

abstract class AllPatientWithAdminRepository{
  Future<Response> getAllPatientWithAdmin(AllPatientModel patientModel,{int page =1,int per_page=20});
}