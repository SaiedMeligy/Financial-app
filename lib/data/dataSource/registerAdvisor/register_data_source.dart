import 'package:dio/dio.dart';

import '../../../domain/entities/RegisterModel.dart';

abstract class RegisterDataSource{
  Future<Response> register(RegisterDataRequest data);
}