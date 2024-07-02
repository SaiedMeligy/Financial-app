

import 'package:bloc/bloc.dart';
import 'package:experts_app/features/homeAdmin/staticScreen/manager/states.dart';

import '../../../../core/Services/web_services.dart';
import '../../../../data/dataSource/homeAdmin/home_admin_data_Source.dart';
import '../../../../data/dataSource/homeAdmin/home_admin_data_source_imp.dart';
import '../../../../data/repository_imp/admin_repository_imp/home_admin_repository_imp.dart';
import '../../../../domain/entities/HomeAdminModel.dart';
import '../../../../domain/repository/homeAdminRepository/home_admin_repository.dart';
import '../../../../domain/useCase/HomeAdmin/home_admin_use_case.dart';

class HomeAdminCubit extends Cubit<HomeAdminStates> {
  HomeAdminCubit() : super(LoadingHomeAdmin());

  late HomeAdminUseCase homeAdminUseCase;
  late HomeAdminRepository homeAdminRepository;
  late HomeAdminDataSource homeAdminDataSource;

  Future<void> getHomeAdmin() async {
    WebServices service = WebServices();
    homeAdminDataSource = HomeAdminDataSourceImp(service.freeDio);
    homeAdminRepository = HomeAdminRepositoryImp(homeAdminDataSource);
    homeAdminUseCase = HomeAdminUseCase(homeAdminRepository);
    emit(LoadingHomeAdmin());
    try {
      var result = await homeAdminUseCase.execute(HomeAdminModel());
      print('API Response: ${result.data}');

      final data = HomeAdminModel.fromJson(result.data);
      emit(SuccessHomeAdmin(data.homeAdmin));
    } catch (error) {
      emit(ErrorHomeAdmin(error.toString()));
    }
  }
}
