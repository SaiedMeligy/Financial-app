import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllSessionModel.dart';
abstract class AllSessionWithAdminDataSource {

  Future<Response> getAllSessionWithAdmin(AllSessionModel sessionModel,{int page,int per_page,String searchQuery = ''});
}