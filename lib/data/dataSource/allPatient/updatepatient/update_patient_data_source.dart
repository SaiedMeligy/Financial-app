import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';


abstract class UpdatePatientDataSource{
  Future<Response> updatePatient(int id,Pationts patient);
  }
