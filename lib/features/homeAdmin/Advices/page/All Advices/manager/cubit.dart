import 'package:bloc/bloc.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/domain/entities/AdviceMode.dart';
import 'package:experts_app/features/homeAdmin/Advices/page/All%20Advices/manager/states.dart';
import '../../../../../../data/dataSource/Advices/AllAdvices/advices_data_source_imp.dart';
import '../../../../../../data/dataSource/Advices/AllAdvices/all_advices_data_source.dart';
import '../../../../../../data/repository_imp/all_advices_repository_imp.dart';
import '../../../../../../domain/repository/advices/AllAdvices/all_advices_repository.dart';
import '../../../../../../domain/useCase/advices/allAdvices/all_advices_use_case.dart';

class AllAdvicesCubit extends Cubit<AllAdvicesStates> {
  AllAdvicesCubit() : super(LoadingAllAdvices());

  late AllAdvicesUseCase allAdvicesUseCase;
  late AllAdvicesRepository allAdvicesRepository;
  late AllAdvicesDataSource allAdvicesDataSource;



  Future<void> getAllAdvices() async {
    WebServices service = WebServices();
    allAdvicesDataSource = AllAdvicesDataSourceImp(service.freeDio);
    allAdvicesRepository = AllAdvicesRepositoryImp(allAdvicesDataSource);
    allAdvicesUseCase = AllAdvicesUseCase(allAdvicesRepository);
    emit(LoadingAllAdvices());
    try {
      var result = await allAdvicesUseCase.execute(AdviceModel());
      print('API Response: ${result.data}');

      final data = AdviceModel.fromJson(result.data);
      if (data != null) {
        emit(SuccessAllAdvices(data.advices!));
      } else {
        emit(ErrorAllAdvices("No consultation services found"));
      }
    } catch (error) {
      emit(ErrorAllAdvices(error.toString()));
    }
  }




}