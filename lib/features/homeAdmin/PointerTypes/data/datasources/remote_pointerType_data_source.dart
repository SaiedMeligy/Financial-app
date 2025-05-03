
import 'package:experts_app/features/homeAdmin/PointerTypes/data/models/PointerTypeModel.dart';

abstract class PointerTypeRemoteDataSource {
  Future<List<PointerTypeModel>> getAllPointerTypes();
  Future<void> addPointerTypes(PointerTypeModel pointerType);
  Future<void> updatePointerTypes(PointerTypeModel pointerType);
  Future<void> deletePointerTypes(int id);
}