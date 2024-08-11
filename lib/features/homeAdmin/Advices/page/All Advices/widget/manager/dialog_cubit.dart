import 'package:bloc/bloc.dart';

import '../../../../../../../core/Services/web_services.dart';
import '../../../../../../../data/dataSource/Advices/deleteAdvice/delete_advice_data_source.dart';
import '../../../../../../../data/dataSource/Advices/deleteAdvice/delete_advice_data_source_imp.dart';
import '../../../../../../../data/dataSource/Advices/updateAdvice/update_advice_data_source.dart';
import '../../../../../../../data/dataSource/Advices/updateAdvice/update_advice_data_source_imp.dart';
import '../../../../../../../data/repository_imp/delete_advice_repository_imp.dart';
import '../../../../../../../data/repository_imp/update_advice_repository_imp.dart';
import '../../../../../../../domain/repository/advices/deleteAdvice/delete_advice_repository.dart';
import '../../../../../../../domain/repository/advices/updateAdvice/update_advice_repository.dart';
import '../../../../../../../domain/useCase/advices/deleteAdvice/delete_advice_use_case.dart';
import '../../../../../../../domain/useCase/advices/updateAdvice/update_advice_use_case.dart';
import 'dialog_state.dart';

class UpdateAdviceCubit extends Cubit<UpdateAdviceStates>{
  UpdateAdviceCubit() : super(LoadingUpdateAdviceState());
  late UpdateAdviceUseCase updateAdviceUseCase;
  late UpdateAdviceRepository updateAdviceRepository;
  late UpdateAdviceDataSource updateAdviceDataSource;

  Future<void> updateAdvice(int id ,String title) async {
    WebServices service = WebServices();
    updateAdviceDataSource =
        UpdateAdviceDataSourceImp(service.freeDio);
    updateAdviceRepository =
        UpdateAdviceRepositoryImp(updateAdviceDataSource);
    updateAdviceUseCase =
        UpdateAdviceUseCase(updateAdviceRepository);
    emit(LoadingUpdateAdviceState());

    try {
      final response = await updateAdviceUseCase.execute(id, title);

      emit(SuccessUpdateAdviceState(response.data));
    } catch (error) {
      emit(ErrorUpdateAdvices(error.toString()));
    }
  }

  late DeleteAdviceUseCase deleteAdviceUseCase;
  late DeleteAdviceRepository deleteAdviceRepository;
  late DeleteAdviceDataSource deleteAdviceDataSource;

  Future<void> deleteAdvice(int id ) async {
    WebServices service = WebServices();
    deleteAdviceDataSource =
        DeleteAdviceDataSourceImp(service.freeDio);
    deleteAdviceRepository =
        DeleteAdviceRepositoryImp(deleteAdviceDataSource);
    deleteAdviceUseCase =
        DeleteAdviceUseCase(deleteAdviceRepository);
    emit(LoadingUpdateAdviceState());

    try {
      final response = await deleteAdviceUseCase.execute(id);

      emit(SuccessDeleteAdviceState(response.data));
    } catch (error) {
      emit(ErrorUpdateAdvices(error.toString()));
    }
  }


  }