import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/data/datasources/remote_pointerType_data_sourceImpl.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/data/models/PointerTypeModel.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/data/repositories/PointerTypeRepositoryImpl.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/domain/usecases/PointersTypeUseCases.dart';
import 'package:meta/meta.dart';
part 'pointer_types_state.dart';

class PointerTypeCubit extends Cubit<PointerTypesState> {
  late final GetAllPointerTypes _getAll;
  late final AddPointerType _add;
  late final UpdatePointerType _update;
  late final DeletePointerType _delete;

  PointerTypeCubit() : super(PointerTypesInitial()) {
    final dio = Dio();
    final dataSource = PointerTypeRemoteDataSourceImpl(dio: dio);
    final repository = PointerTypeRepositoryImpl(dataSource);

    _getAll = GetAllPointerTypes(repository);
    _add = AddPointerType(repository);
    _update = UpdatePointerType(repository);
    _delete = DeletePointerType(repository);
  }

  Future<void> fetchPointerTypes() async {
    try {
      emit(PointerTypesLoading());
      final pointerTypes = await _getAll();
      emit(PointerTypesLoaded(pointerTypes));
    } catch (e) {
      emit(PointerTypesError(e.toString()));
    }
  }

  Future<void> addPointerType(PointerTypeModel pointerType) async {
    try {
      emit(PointerTypesLoading());
      await _add(pointerType);
      fetchPointerTypes();
    } catch (e) {
      emit(PointerTypesError(e.toString()));
    }
  }

  Future<void> updatePointerType(PointerTypeModel pointerType) async {
    try {
      emit(PointerTypesLoading());
      await _update(pointerType);
      fetchPointerTypes();
    } catch (e) {
      emit(PointerTypesError(e.toString()));
    }
  }

  Future<void> deletePointerType(int id) async {
    try {
      emit(PointerTypesLoading());
      await _delete(id);
      fetchPointerTypes();
    } catch (e) {
      emit(PointerTypesError(e.toString()));
    }
  }
}
