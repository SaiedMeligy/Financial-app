import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

abstract class AllPatientRepository{
  Future<Response> getAllPatient(AllPatientModel patientModel,{int page,int per_page,String searchQuery=''});
}