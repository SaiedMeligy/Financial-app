import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

abstract class UpdatePatientRepository{

  Future<Response> updatePatient(int id,Pationts patient);
}