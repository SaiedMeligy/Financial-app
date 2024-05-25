import 'package:equatable/equatable.dart';
import 'package:experts_app/domain/entities/pointerModel.dart';

abstract class AllPointersStates extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingAllPointers extends AllPointersStates {}

class SuccessAllPointers extends AllPointersStates {
  final List<Pointers> pointers1;
  final List<Pointers> pointers2;
  final List<Pointers> pointers3;

  SuccessAllPointers(this.pointers1, this.pointers2, this.pointers3);

  @override
  List<Object> get props => [pointers1, pointers2, pointers3];
}

class ErrorAllPointers extends AllPointersStates {
  final String errorMessage;

  ErrorAllPointers(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
