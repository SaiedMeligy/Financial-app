import 'package:dio/dio.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import '../../../../domain/entities/AdvisorProfileModel.dart';
import 'update_profile_data_source.dart';

class UpdateProfileDataSourceImp implements UpdateProfileDataSource{
  final Dio dio;
  UpdateProfileDataSourceImp(this.dio);
  @override
  Future<Response> updateProfile({required AdvisorModel advisor}) async{
    return await dio.post(
      "/api/user/updateProfile",
      options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token": CacheHelper.getData(key: "token")
          },
      ),
      data: {
        "id":advisor.id,
        "name":advisor.name,
        "password":advisor.password,
        "phone_number":advisor.phoneNumber,
    }

      );


  }

}