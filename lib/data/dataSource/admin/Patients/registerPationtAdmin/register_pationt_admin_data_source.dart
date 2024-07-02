import 'package:dio/dio.dart';

import '../../../../../domain/entities/RegisterPatient.dart';

abstract class RegisterPatientWithAdminDataSource{
  Future<Response> registerWithAdmin(RegisterPatientDataRequest data);
}