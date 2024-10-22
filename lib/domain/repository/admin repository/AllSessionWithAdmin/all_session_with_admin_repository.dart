import 'package:dio/dio.dart';

import '../../../entities/AllSessionModel.dart';


abstract class AllSessionWithAdminRepository{
  Future<Response> getAllSessionWithAdmin(AllSessionModel sessionModel,{int page, int per_page});
}