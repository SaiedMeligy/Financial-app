import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/datasource/remote_PointerTypeEvalution_data_source.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/AllSessionPointersTypeEvaluation.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/DescImprovement.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/OneSessionPointersEvaluations.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/PointerImprovement.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/SessionPointersEvaluations.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/domain/repository/AllSessionPointersEvaluationRepository.dart';

class SessionPointersEvaluationsRepositoryImpl implements SessionPointersEvaluationsRepository{
  final PointerTypeEvalutionRemoteDataSource remoteDataSource ;

  SessionPointersEvaluationsRepositoryImpl(this.remoteDataSource) ;

  @override
  Future<List<AllSessionPointersTypeEvaluation>> getAllSeissonsPointerEvalutions(Map<String,dynamic> data) => remoteDataSource.getEvalutionPointersForAllSession(data);

  @override
  Future<OneSessionPointersEvaluations> OneSeissonsPointerEvalutions(Map<String,dynamic> data) => remoteDataSource.getEvalutionPointersForSession(data);

  @override
  Future<void> editPointerEvaluation(SessionPointersEvaluations sessionPointersEvaluations) => remoteDataSource.editPointerEvaluation(sessionPointersEvaluations);

  @override
  Future<void> deletePointerTypes(int id) => remoteDataSource.deletePointerTypes(id);

  @override
  Future<void> addPointerTypes(Map<String,dynamic> data) => remoteDataSource.addPointerTypes(data);

  @override
  Future<List<DescImprovement>> getDescImprovement(Map<String,dynamic> data) => remoteDataSource.getDescImprovement(data);

  @override
  Future<List<PointerImprovement>> getPointerImprovement(Map<String,dynamic> data) => remoteDataSource.getPointerImprovement(data);

  @override
  Future<String> getPatientName(Map<String,dynamic> data) => remoteDataSource.getPatientName(data);
}