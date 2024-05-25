import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../../../../../core/Services/web_services.dart';
import '../../../../../../../data/dataSource/Pointers/deletePointer/delete_pointer_data_source.dart';
import '../../../../../../../data/dataSource/Pointers/deletePointer/delete_pointer_data_source_imp.dart';
import '../../../../../../../data/dataSource/Pointers/updatePointer/update_pointer_data_source.dart';
import '../../../../../../../data/dataSource/Pointers/updatePointer/update_pointer_data_source_imp.dart';
import '../../../../../../../data/repository_imp/delete_pointer_repository_imp.dart';
import '../../../../../../../data/repository_imp/update_pointer_repository_imp.dart';
import '../../../../../../../domain/repository/pointer/deletePointer/delete_pointer_repository.dart';
import '../../../../../../../domain/repository/pointer/updatePointer/update_pointer_repository.dart';
import '../../../../../../../domain/useCase/Pointers/deletePointer/delete_pointer_use_case.dart';
import '../../../../../../../domain/useCase/Pointers/updatePointer/update_pointer_use_case.dart';
import 'dialog_state.dart';

class UpdatePointerCubit extends Cubit<UpdatePointerStates>{
  UpdatePointerCubit() : super(LoadingUpdatePointerState());

  late UpdatePointerUseCase updatePointerUseCase;
  late UpdatePointerRepository updatePointerRepository;
  late UpdatePointerDataSource updatePointerDataSource;

  Future<void> updatePointer(int id ,String title) async {
    WebServices service = WebServices();
    updatePointerDataSource =
        UpdatePointerDataSourceImp(service.freeDio);
    updatePointerRepository =
        UpdatePointerRepositoryImp(updatePointerDataSource);
    updatePointerUseCase =
        UpdatePointerUseCase(updatePointerRepository);
    emit(LoadingUpdatePointerState());

    try {
      final response = await updatePointerUseCase.execute(id, title);

      emit(SuccessUpdatePointerState(response.data));
    } catch (error) {
      emit(ErrorUpdatePointers(error.toString()));
    }
  }

  late DeletePointerUseCase deletePointerUseCase;
  late DeletePointerRepository deletePointerRepository;
  late DeletePointerDataSource deletePointerDataSource;

  Future<void> deletePointer(int id ) async {
    WebServices service = WebServices();
    deletePointerDataSource =
        DeletePointerDataSourceImp(service.freeDio);
    deletePointerRepository =
        DeletePointerRepositoryImp(deletePointerDataSource);
    deletePointerUseCase =
        DeletePointerUseCase(deletePointerRepository);
    emit(LoadingUpdatePointerState());

    try {
      final response = await deletePointerUseCase.execute(id);

      emit(SuccessDeletePointerState(response.data));
    } catch (error) {
      emit(ErrorUpdatePointers(error.toString()));
    }
  }


  }