import 'package:dio/dio.dart';

import '../../../entities/pointerModel.dart';

abstract class AllPointersRepository{
  Future<Response> getAllPointers(PointerModel pointerModel);
}