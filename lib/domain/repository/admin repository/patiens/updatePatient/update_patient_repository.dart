import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

abstract class UpdatePatientWithAdminRepository{

  Future<Response> updatePatientWithAdmin(int id,Pationts patient);
}