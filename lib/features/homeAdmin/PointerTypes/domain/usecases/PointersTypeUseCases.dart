import 'package:experts_app/features/homeAdmin/PointerTypes/data/models/PointerTypeModel.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/domain/repositories/PointerTypeRepository.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/cubit/pointer_types_cubit.dart';

class GetAllPointerTypes {
  final PointerTypeRepository repo;
  GetAllPointerTypes(this.repo);
  Future<List<PointerTypeModel>> call() => repo.getAll();
}

class AddPointerType {
  final PointerTypeRepository repo;
  AddPointerType(this.repo);

  Future<void> call(PointerTypeModel pointerType) => repo.add(pointerType);
}

class DeletePointerType {
  final PointerTypeRepository repository;

  DeletePointerType(this.repository);

  Future<void> call(int id) async {
    print('===========) $id');
    await repository.deletePointerType(id);
  }
}


class UpdatePointerType {
  final PointerTypeRepository repository;

  UpdatePointerType(this.repository);

  Future<void> call(PointerTypeModel pointerType) async {
    await repository.updatePointerType(pointerType);
  }
}
