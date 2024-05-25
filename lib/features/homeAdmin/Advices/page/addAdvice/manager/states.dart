abstract class AddAdviceState{}
  class LoadingAddAdviceState extends AddAdviceState{}
  class SuccessAddAdviceState extends AddAdviceState{}
  class ErrorAddAdviceState extends AddAdviceState{
   String errorMessage;
   ErrorAddAdviceState(this.errorMessage);
  }
