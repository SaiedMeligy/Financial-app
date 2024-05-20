abstract class ConsultationStoreStates{}
class LoadingConsultationState extends ConsultationStoreStates{}
class SuccessConsultationState extends ConsultationStoreStates{}
class ErrorConsultationState extends ConsultationStoreStates{
  final String errorMessage;
  ErrorConsultationState(this.errorMessage);
}