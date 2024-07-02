import 'package:dio/dio.dart';

import '../../entities/AllSessionModel.dart';

abstract class AllSessionRepository{
  Future<Response> getAllSession(AllSessionModel sessionModel);
}