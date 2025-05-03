part of 'pointer_types_cubit.dart';

@immutable
abstract class PointerTypesState {}

class PointerTypesInitial extends PointerTypesState {}

class PointerTypesLoading extends PointerTypesState {

}

class PointerTypesSuccess extends PointerTypesState {
  final List<PointerTypeModel> pointerTypes;
  PointerTypesSuccess(this.pointerTypes);
}

class PointerTypesLoaded extends PointerTypesState {
  final List<PointerTypeModel> pointerTypelist;
  PointerTypesLoaded(this.pointerTypelist);
}

class PointerTypesError extends PointerTypesState {
  final String message;
  PointerTypesError(this.message);
}

class PointerTypesAdded extends PointerTypesState {}

class PointerTypesUpdated extends PointerTypesState {}

class PointerTypesDeleted extends PointerTypesState {}

