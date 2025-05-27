import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/AllSessionPointersTypeEvaluation.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/DescImprovement.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/OneSessionPointersEvaluations.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/PointerImprovement.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/SessionPointersEvaluations.dart';

abstract class PointerTypeEvalutionRemoteDataSource{
  Future<OneSessionPointersEvaluations> getEvalutionPointersForSession(Map<String,dynamic> data);
  Future<List<AllSessionPointersTypeEvaluation>> getEvalutionPointersForAllSession(Map<String,dynamic> data);
  Future<void> editPointerEvaluation(SessionPointersEvaluations sessionPointersEvaluations);
  Future<void> deletePointerTypes(int id);
  Future<void> addPointerTypes(Map<String,dynamic> data);
  Future<List<DescImprovement>> getDescImprovement(Map<String,dynamic> data);
  Future<List<PointerImprovement>> getPointerImprovement(Map<String,dynamic> data);
  Future<String> getPatientName(Map<String,dynamic> data);
}