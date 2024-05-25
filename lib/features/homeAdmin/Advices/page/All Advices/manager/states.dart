import 'package:experts_app/domain/entities/AdviceMode.dart';


abstract class AllAdvicesStates{}
class LoadingAllAdvices extends AllAdvicesStates{}
class SuccessAllAdvices extends AllAdvicesStates{
  final List<Advices> adviceServices;
  SuccessAllAdvices(this.adviceServices);
}

class ErrorAllAdvices extends AllAdvicesStates{
  final String errorMessage;
  ErrorAllAdvices(this.errorMessage);

}