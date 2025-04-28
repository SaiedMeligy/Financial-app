import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/features/homeAdvisor/Profile%20advisor/manager/states.dart';

import '../../../../core/Services/web_services.dart';
import '../../../../data/dataSource/ProfileAdvisor/profile_data_source.dart';
import '../../../../data/dataSource/ProfileAdvisor/progile_data_source_imp.dart';
import '../../../../data/dataSource/ProfileAdvisor/updateProfile/update_profile_data_source.dart';
import '../../../../data/dataSource/ProfileAdvisor/updateProfile/update_profile_data_source_imp.dart';
import '../../../../data/repository_imp/profile_repository_imp.dart';
import '../../../../data/repository_imp/update_profile_repository_imp.dart';
import '../../../../domain/entities/AdvisorProfileModel.dart';
import '../../../../domain/repository/Profile Repository/profile_repository.dart';
import '../../../../domain/repository/Profile Repository/update_profile_repository.dart';
import '../../../../domain/useCase/ProfileUseCase/profile_use_case.dart';
import '../../../../domain/useCase/ProfileUseCase/update_profile_use_case.dart';

class ProfileAdvisorCubit extends Cubit<ProfileAdvisorStates>{
  ProfileAdvisorCubit() : super(LoadingProfileAdvisorState());

  late ProfileUseCase patientUseCase;
  late ProfileRepository patientRepository;
  late ProfileDataSource patientDataSource;

  Future<Response> getProfileAdvisor(int patientId) async {
    WebServices service = WebServices();
    patientDataSource = ProfileDataSourceImp(service.freeDio);
    patientRepository = ProfileRepositoryImp(patientDataSource);
    patientUseCase = ProfileUseCase(patientRepository);



     var result = await patientUseCase.execute(patientId);
    emit(SuccessProfileAdvisorState(result));
    return result;
  }

  late UpdateProfileUseCase updateProfileUseCase;
  late UpdateProfileRepository updateProfileRepository;
  late UpdateProfileDataSource updateProfileDataSource;

  Future<void> updateProfile({required AdvisorModel advisor}) async {
    WebServices service = WebServices();
    updateProfileDataSource = UpdateProfileDataSourceImp(service.freeDio);
    updateProfileRepository = UpdateProfileRepositoryImp(updateProfileDataSource);
    updateProfileUseCase = UpdateProfileUseCase(updateProfileRepository);
    emit(LoadingUpdateProfileState());

    try {
      final response = await updateProfileUseCase.execute(advisor: advisor);
      await getProfileAdvisor(advisor.id!);

      emit(SuccessUpdateProfileState(response.data));
    } catch (error) {
      emit(ErrorProfileAdvisorState(error.toString()));
    }
  }


}