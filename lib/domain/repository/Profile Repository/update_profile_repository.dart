import 'package:dio/dio.dart';

import '../../entities/AdvisorProfileModel.dart';

abstract class UpdateProfileRepository{

  Future<Response> updateProfile({required AdvisorModel advisor});
}