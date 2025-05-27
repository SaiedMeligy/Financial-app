import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/AllSessionPointersTypeEvaluation.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/OneSessionPointersEvaluations.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/SessionPointersEvaluations.dart';

import '../../data/models/DescImprovement.dart';
import '../../data/models/PointerImprovement.dart';
import '../repository/AllSessionPointersEvaluationRepository.dart';

class GetAllPointerTypesEvalutionsOfSession {
  final SessionPointersEvaluationsRepository repo;
  GetAllPointerTypesEvalutionsOfSession(this.repo);
  Future<OneSessionPointersEvaluations> call(Map<String,dynamic> data) => repo.OneSeissonsPointerEvalutions(data);
}

class GetAllPointerTypesEvalutionsOfAllSession {
  final SessionPointersEvaluationsRepository repo;
  GetAllPointerTypesEvalutionsOfAllSession(this.repo);
  Future<List<AllSessionPointersTypeEvaluation>> call(Map<String,dynamic> data) => repo.getAllSeissonsPointerEvalutions(data);
}

class DeletePointerTypeEvalution {
  final SessionPointersEvaluationsRepository repository;

  DeletePointerTypeEvalution(this.repository);

  Future<void> call(int id) async {
    await repository.deletePointerTypes(id);
  }
}

class UpdatePointerTypeEvalution {
  final SessionPointersEvaluationsRepository repository;

  UpdatePointerTypeEvalution(this.repository);

  Future<void> call(SessionPointersEvaluations sessionPointersEvaluations) async {
    await repository.editPointerEvaluation(sessionPointersEvaluations);
  }
}

class AddPointerTypeEvalution {
  final SessionPointersEvaluationsRepository repository;

  AddPointerTypeEvalution(this.repository);

  Future<void> call(Map<String,dynamic> data) async {
    await repository.addPointerTypes(data);
  }
}


class GetDescImprovement {
  final SessionPointersEvaluationsRepository repository;
  GetDescImprovement(this.repository);
  Future<List<DescImprovement>> call(Map<String,dynamic> data) => repository.getDescImprovement(data);
}

class GetPointerImprovement {
  final SessionPointersEvaluationsRepository repository;
  GetPointerImprovement(this.repository);
  Future<List<PointerImprovement>> call(Map<String,dynamic> data) => repository.getPointerImprovement(data);
}

class GetPatientName {
  final SessionPointersEvaluationsRepository repository;
  GetPatientName(this.repository);
  Future<String> call(Map<String,dynamic> data) => repository.getPatientName(data);
}

