import 'package:dio/dio.dart';

import '../../../../domain/entities/pointerModel.dart';

abstract class AllPointersDataSource {

  Future<Response> getAllPointers(PointerModel pointerModel);
}