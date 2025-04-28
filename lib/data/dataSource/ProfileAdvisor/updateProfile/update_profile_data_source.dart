import 'package:dio/dio.dart';

import '../../../../domain/entities/AdvisorProfileModel.dart';


abstract class UpdateProfileDataSource{
  Future<Response> updateProfile({required AdvisorModel advisor});
  }
