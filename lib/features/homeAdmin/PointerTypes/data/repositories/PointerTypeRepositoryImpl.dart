import 'package:experts_app/features/homeAdmin/PointerTypes/data/datasources/remote_pointerType_data_source.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/data/models/PointerTypeModel.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/domain/repositories/PointerTypeRepository.dart';

class PointerTypeRepositoryImpl implements PointerTypeRepository {
  final PointerTypeRemoteDataSource remote;

  PointerTypeRepositoryImpl(this.remote);

  @override
  Future<List<PointerTypeModel>> getAll() => remote.getAllPointerTypes();

  @override
  Future<void> add(PointerTypeModel pointerType) =>
      remote.addPointerTypes(PointerTypeModel(
        id: pointerType.id!,
        name: pointerType.name!,
        desc: pointerType.desc!,
      ));

  @override
  Future<void> updatePointerType(PointerTypeModel pointerType) =>
      remote.updatePointerTypes(
        PointerTypeModel(
          id: pointerType.id!,
          name: pointerType.name!,
          desc: pointerType.desc!,
        )
      );

  @override
  Future<void> deletePointerType(int id) => remote.deletePointerTypes(id);
}
