import '../../../../../domain/entities/AllAdvisorsModel.dart';

sealed class AllAdvisorState {}
class LoadingAllAdvisorState extends AllAdvisorState{}
class SuccessAllAdvisorState extends AllAdvisorState{
  final List<Advisors> advisors;
  SuccessAllAdvisorState( this.advisors);
}
class ErrorAllAdvisorState extends AllAdvisorState{
  final String errorMessage;
  ErrorAllAdvisorState(this.errorMessage);
}