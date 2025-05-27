part of 'pointer_type_evalution_cubit.dart';

@immutable
sealed class PointerTypeEvalutionState {}

final class PointerTypeEvalutionInitial extends PointerTypeEvalutionState {}

class PointerTypeEvalutionOneSessionLoading extends PointerTypeEvalutionState {

}

class PointerTypeEvalutionOneSessionSuccess extends PointerTypeEvalutionState {
  final OneSessionPointersEvaluations oneSessionPointersEvaluations;
  PointerTypeEvalutionOneSessionSuccess(this.oneSessionPointersEvaluations);
}

class PointerTypeEvalutionOneSessionLoaded extends PointerTypeEvalutionState {
  final OneSessionPointersEvaluations oneSessionPointersEvaluations;
  PointerTypeEvalutionOneSessionLoaded(this.oneSessionPointersEvaluations);
}

class PointerTypeEvalutionOneSessionError extends PointerTypeEvalutionState {
  final String message;
  PointerTypeEvalutionOneSessionError(this.message);
}

class PointerTypeEvalutionAllSessionLoading extends PointerTypeEvalutionState {

}

class PointerTypeEvalutionAllSessionSuccess extends PointerTypeEvalutionState {
  final List<AllSessionPointersTypeEvaluation> allSessionPointersTypeEvaluation;
  PointerTypeEvalutionAllSessionSuccess(this.allSessionPointersTypeEvaluation);
}

class PointerTypeEvalutionAllSessionLoaded extends PointerTypeEvalutionState {
  final List<AllSessionPointersTypeEvaluation> allSessionPointersTypeEvaluation;
  final List<DescImprovement> allDescImprovement;
  final List<PointerImprovement> allPointerImprovement;
  final String patientName;
  double ehancePercentage = 0 ;
  List<Map<String,dynamic>> ehanceData = [] ;
  Map<int , String> numbers = {1 : "الاولى", 2 : "الثانيه", 3 : "الثالثه", 4 : "الرابعه", 5 : "الخامسه", 6 : "السادسه", 7 : "السابعه", 8 : "الثامنه", 9 : "التاسعه", 10 : "العاشره",};
  PointerTypeEvalutionAllSessionLoaded(
    this.allSessionPointersTypeEvaluation ,
    this.allDescImprovement ,
    this.allPointerImprovement ,
    this.patientName
  ){
    ehanceData = getEhancePercentage(allSessionPointersTypeEvaluation);
  }
  List<Map<String,dynamic>> getEhancePercentage(List<AllSessionPointersTypeEvaluation> allSessionPointersTypeEvaluation){
    List<Map<String,dynamic>> data = [] ;
    allSessionPointersTypeEvaluation.forEach((element) {
      data.add(
          {
            "name" : " الجلسه ${numbers[element.sessionNumber]}",
            "value" : calculatePersentage(element.sessionPointersEvaluations!)
          }
      );
    });
    ehancePercentage = double.parse((((data.last['value'] - data.first['value'])/data.first['value']) * 100 as num).toDouble().toStringAsFixed(2).toString());
    data.add(
        {
          "name" : "نسبة التحسن",
          "value" : double.parse((((data.last['value'] - data.first['value'])/data.first['value']) * 100 as num).toDouble().toStringAsFixed(2).toString())
        }
    );
    return data ;
  }
  double calculatePersentage(List<SessionPointersEvaluations> sessionPointersEvaluations){
    double percentage = 0 ;
    sessionPointersEvaluations.forEach((element) {
      percentage += element.evaluation! ;
    });
    percentage = (percentage / sessionPointersEvaluations.length) * 10 ;
    return percentage ;
  }
}

class PointerTypeEvalutionAllSessionEmpty extends PointerTypeEvalutionState {

}

class PointerTypeEvalutionAllSessionError extends PointerTypeEvalutionState {
  final String message;
  PointerTypeEvalutionAllSessionError(this.message);
}
