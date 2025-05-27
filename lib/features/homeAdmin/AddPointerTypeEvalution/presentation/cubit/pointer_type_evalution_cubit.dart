import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/datasource/remote_PointerTypeEvalution_data_source_impl.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/AllSessionPointersTypeEvaluation.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/DescImprovement.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/OneSessionPointersEvaluations.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/PointerImprovement.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/SessionPointersEvaluations.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/repository/SessionPointersEvaluationsRepositoryImpl.dart';
import 'package:meta/meta.dart';

import '../../domain/usecase/SessionPointersEvaluationUseCases.dart';
part 'pointer_type_evalution_state.dart';

class PointerTypeEvalutionCubit extends Cubit<PointerTypeEvalutionState> {
  late final GetAllPointerTypesEvalutionsOfSession _getSessionPointer;
  late final GetAllPointerTypesEvalutionsOfAllSession _getAllSessionPointer;
  late final GetDescImprovement _getDescImprovement;
  late final GetPatientName _getPatientName;
  late final GetPointerImprovement _getPointerImprovement;
  late final DeletePointerTypeEvalution _delete;
  late final UpdatePointerTypeEvalution _update;
  late final AddPointerTypeEvalution _add;

  PointerTypeEvalutionCubit() : super(PointerTypeEvalutionInitial()) {
    final dio = Dio();
    final dataSource = PointerTypeEvalutionRemoteDataSourceImpl(dio: dio);
    final repository = SessionPointersEvaluationsRepositoryImpl(dataSource);

    _getSessionPointer = GetAllPointerTypesEvalutionsOfSession(repository);
    _getAllSessionPointer = GetAllPointerTypesEvalutionsOfAllSession(repository);
    _getDescImprovement = GetDescImprovement(repository);
    _getPointerImprovement = GetPointerImprovement(repository);
    _getPatientName = GetPatientName(repository);
    _delete = DeletePointerTypeEvalution(repository);
    _update = UpdatePointerTypeEvalution(repository);
    _add = AddPointerTypeEvalution(repository);
  }

  Future<void> fetchAllSessionAllPointer(Map<String,dynamic> data) async {
    try {
      emit(PointerTypeEvalutionAllSessionLoading());
      final allSessionPointersEvaluations = await _getAllSessionPointer(data);
      final descImprovement = await _getDescImprovement(data);
      final pointerImprovement = await _getPointerImprovement(data);
      final patientName = await _getPatientName(data);
      if(allSessionPointersEvaluations.length == 0)
        emit(PointerTypeEvalutionAllSessionEmpty());
      else
        emit(PointerTypeEvalutionAllSessionLoaded(allSessionPointersEvaluations , descImprovement , pointerImprovement , patientName));
    } catch (e) {
      emit(PointerTypeEvalutionAllSessionError(e.toString()));
    }
  }

  Future<void> fetchSessionAllPointer(Map<String,dynamic> data) async {
    try {
      emit(PointerTypeEvalutionOneSessionLoading());
      final oneSessionPointersEvaluations = await _getSessionPointer(data);
      emit(PointerTypeEvalutionOneSessionLoaded(oneSessionPointersEvaluations));
    } catch (e) {
      emit(PointerTypeEvalutionOneSessionError(e.toString()));
    }
  }

  Future<void> addPointerTypeEvalution(Map<String,dynamic> data) async {
    try {
      emit(PointerTypeEvalutionOneSessionLoading());
      await _add(data);
      fetchSessionAllPointer(data);
    } catch (e) {
      emit(PointerTypeEvalutionOneSessionError(e.toString()));
    }
  }

  Future<void> updatePointerTypeEvalution(SessionPointersEvaluations sessionPointersEvaluations , Map<String,dynamic> data) async {
    try {
      emit(PointerTypeEvalutionOneSessionLoading());
      await _update(sessionPointersEvaluations);
      fetchSessionAllPointer(data);
    } catch (e) {
      emit(PointerTypeEvalutionOneSessionError(e.toString()));
    }
  }

  Future<void> deletePointerTypeEvalution(int id , Map<String,dynamic> data) async {
    try {
      emit(PointerTypeEvalutionOneSessionLoading());
      await _delete(id);
      fetchSessionAllPointer(data);
    } catch (e) {
      emit(PointerTypeEvalutionOneSessionError(e.toString()));
    }
  }
}
