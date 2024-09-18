abstract class AddComplaintState{}
  class LoadingAddComplaintState extends AddComplaintState{}
  class SuccessAddComplaintState extends AddComplaintState{}
  class ErrorAddComplaintState extends AddComplaintState{
   String errorMessage;
   ErrorAddComplaintState(this.errorMessage);
  }
