import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllSessionModel.dart';
abstract class AllSessionDataSource {

  Future<Response> getAllSession(AllSessionModel sessionModel,{int page,int per_page,String searchQuery});
}