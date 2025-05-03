import 'package:experts_app/features/homeAdmin/PointerTypes/data/models/PointerTypeModel.dart';

abstract class PointerTypeRepository {
  Future<List<PointerTypeModel>> getAll();
  Future<void> add(PointerTypeModel pointerType);
  Future<void> updatePointerType(PointerTypeModel pointerType);
  Future<void> deletePointerType(int id);
}