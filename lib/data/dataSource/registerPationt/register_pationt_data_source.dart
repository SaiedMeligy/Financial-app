import 'package:dio/dio.dart';

import '../../../domain/entities/RegisterPatient.dart';

abstract class RegisterPatientDataSource{
  Future<Response> register(RegisterPatientDataRequest data);
}