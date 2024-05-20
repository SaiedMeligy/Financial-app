import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/data/repository_imp/delete_consultation_repository_imp.dart';

import '../../../../../../core/Services/web_services.dart';
import '../../../../../../data/dataSource/ConsultationServices/deleteConsultation/Consultation_delete_data_source.dart';
import '../../../../../../data/dataSource/ConsultationServices/deleteConsultation/Consultation_delete_data_source_imp.dart';
import '../../../../../../data/dataSource/ConsultationServices/updateConsultation/Consultation_update_data_source.dart';
import '../../../../../../data/dataSource/ConsultationServices/updateConsultation/Consultation_update_data_source_imp.dart';
import '../../../../../../data/repository_imp/update_consultation_repository_imp.dart';
import '../../../../../../domain/entities/UpdateConsultationModel.dart';
import '../../../../../../domain/repository/ConsultationServices/deleteConsultation/delete_consultation_repository.dart';
import '../../../../../../domain/repository/ConsultationServices/updateConsultation/update_consultation_repository.dart';
import '../../../../../../domain/useCase/ConsultationServices/deleteConsultation/delete_consultation_use_case.dart';
import '../../../../../../domain/useCase/ConsultationServices/updateConsultation/update_consultation_use_case.dart';
import '../../manager/states.dart';
import 'dialog_state.dart';

class UpdateConsultationCubit extends Cubit<UpdateConsultationStates>{
  UpdateConsultationCubit() : super(LoadingUpdateConsultationState());
  late UpdateConsultationUseCase updateConsultationUseCase;
  late UpdateConsultationRepository updateConsultationRepository;
  late UpdateConsultationDataSource updateConsultationDataSource;

  Future<void> updateConsultation(int id ,String name,String description) async {
    WebServices service = WebServices();
    updateConsultationDataSource =
        UpdateConsultationDataSourceImp(service.freeDio);
    updateConsultationRepository =
        UpdateConsultationRepositoryImp(updateConsultationDataSource);
    updateConsultationUseCase =
        UpdateConsultationUseCase(updateConsultationRepository);
    emit(LoadingUpdateConsultationState());

    try {
      final response = await updateConsultationUseCase.execute(id, name, description);

      emit(SuccessUpdateConsultationState(response.data));
    } catch (error) {
      emit(ErrorUpdateConsultations(error.toString()));
    }
  }

  late DeleteConsultationUseCase deleteConsultationUseCase;
  late DeleteConsultationRepository deleteConsultationRepository;
  late DeleteConsultationDataSource deleteConsultationDataSource;

  Future<void> deleteConsultation(int id ) async {
    WebServices service = WebServices();
    deleteConsultationDataSource =
        DeleteConsultationDataSourceImp(service.freeDio);
    deleteConsultationRepository =
        DeleteUpdateConsultationRepositoryImp(deleteConsultationDataSource);
    deleteConsultationUseCase =
        DeleteConsultationUseCase(deleteConsultationRepository);
    emit(LoadingUpdateConsultationState());

    try {
      final response = await deleteConsultationUseCase.execute(id);

      emit(SuccessDeleteConsultationState(response.data));
    } catch (error) {
      emit(ErrorUpdateConsultations(error.toString()));
    }
  }


  }