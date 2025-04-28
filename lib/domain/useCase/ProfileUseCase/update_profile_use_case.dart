import 'package:dio/dio.dart';

import '../../entities/AdvisorProfileModel.dart';
import '../../repository/Profile Repository/update_profile_repository.dart';


class UpdateProfileUseCase{
  final UpdateProfileRepository updateProfileRepository;
  UpdateProfileUseCase(this.updateProfileRepository);

  Future<Response> execute({required AdvisorModel advisor})async{

    return await updateProfileRepository.updateProfile(advisor: advisor);
  }
}