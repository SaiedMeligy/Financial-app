
import 'package:bloc/bloc.dart';
import 'package:experts_app/domain/entities/AllAdvisorsModel.dart';
import 'package:experts_app/features/homeAdmin/addSession/widget/manager/states.dart';

import '../../../../../core/Services/web_services.dart';
import '../../../../../data/dataSource/getAdvisors/all_advisor_data_source.dart';
import '../../../../../data/dataSource/getAdvisors/get_advisor_data_source_imp.dart';
import '../../../../../data/repository_imp/all_advisors_repository_imp.dart';
import '../../../../../domain/repository/advisors/AllAdvisor/all_advisor_repository.dart';
import '../../../../../domain/useCase/advisors/allAdvisor/all_advisor_use_case.dart';

class AllAdvisorCubit extends Cubit<AllAdvisorState> {
  AllAdvisorCubit() : super(LoadingAllAdvisorState());

  late AllAdvisorUseCase allAdvisorUseCase;
  late AllAdvisorRepository allAdvisorRepository;
  late AllAdvisorDataSource allAdvisorDataSource;



  Future<void> getAllAdvisor() async {
    WebServices service = WebServices();
    allAdvisorDataSource = AllAdvisorDataSourceImp(service.freeDio);
    allAdvisorRepository = AllAdvisorRepositoryImp(allAdvisorDataSource);
    allAdvisorUseCase = AllAdvisorUseCase(allAdvisorRepository);
    emit(LoadingAllAdvisorState());
    try {
      var result = await allAdvisorUseCase.execute(AllAdvisorsModel());
      final data = AllAdvisorsModel.fromJson(result.data);
        emit(SuccessAllAdvisorState(data.advisors!));
    } catch (error) {
      emit(ErrorAllAdvisorState(error.toString()));
    }
  }




}