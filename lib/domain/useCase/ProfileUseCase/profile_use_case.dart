import 'package:dio/dio.dart';
import '../../repository/Profile Repository/profile_repository.dart';

class ProfileUseCase{

  final ProfileRepository allAdvicesRepository;

  ProfileUseCase( this.allAdvicesRepository);

  Future<Response> execute(int advisorId){
    return allAdvicesRepository.getProfile(advisorId);
  }
}