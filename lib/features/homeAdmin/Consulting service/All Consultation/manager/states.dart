import '../../../../../domain/entities/ConsultationViewModel.dart';

abstract class AllConsultationStates{}
class LoadingAllConsultations extends AllConsultationStates{}
class SuccessAllConsultations extends AllConsultationStates{
  final List<ConsultationServices> consultationServices;
  SuccessAllConsultations(this.consultationServices);
}

class ErrorAllConsultations extends AllConsultationStates{
  final String errorMessage;
  ErrorAllConsultations(this.errorMessage);

}