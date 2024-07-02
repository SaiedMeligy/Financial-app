
import 'package:bloc/bloc.dart';
import 'package:experts_app/features/homeAdvisor/home/manager/states.dart';

import '../../../../core/Services/web_services.dart';
import '../../../../data/dataSource/homeAdvisor/home_Advisor_data_source_imp.dart';
import '../../../../data/dataSource/homeAdvisor/home_advisor_data_Source.dart';
import '../../../../data/repository_imp/home_advisor_repository_imp.dart';
import '../../../../domain/entities/HomeAdvisorModel.dart';
import '../../../../domain/repository/homeAdvisorRepository/home_advisor_repository.dart';
import '../../../../domain/useCase/HomeAdvisor/home_advisor_use_case.dart';

class HomeAdvisorCubit extends Cubit<HomeAdvisorStates> {
  HomeAdvisorCubit() : super(LoadingHomeAdvisor());

  late HomeAdvisorUseCase homeAdvisorUseCase;
  late HomeAdvisorRepository homeAdvisorRepository;
  late HomeAdvisorDataSource homeAdvisorDataSource;

  Future<void> getHomeAdvisor() async {
    WebServices service = WebServices();
    homeAdvisorDataSource = HomeAdvisorDataSourceImp(service.freeDio);
    homeAdvisorRepository = HomeAdvisorRepositoryImp(homeAdvisorDataSource);
    homeAdvisorUseCase = HomeAdvisorUseCase(homeAdvisorRepository);
    emit(LoadingHomeAdvisor());
    try {
      var result = await homeAdvisorUseCase.execute(HomeAdvisorModel());
      print('API Response: ${result.data}');

      final data = HomeAdvisorModel.fromJson(result.data);
      emit(SuccessHomeAdvisor(data.home));
    } catch (error) {
      emit(ErrorHomeAdvisor(error.toString()));
    }
  }
}
