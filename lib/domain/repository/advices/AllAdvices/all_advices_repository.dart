import 'package:dio/dio.dart';

import '../../../entities/AdviceMode.dart';

abstract class AllAdvicesRepository{
  Future<Response> getAllAdvices(AdviceModel adviceModel);
}