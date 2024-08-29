import 'package:dio/dio.dart';
import '../../../../../../core/config/cash_helper.dart';
import '../../../../../../core/config/constants.dart';
import '../../../../../../domain/entities/AllPatientModel.dart';
import 'all_patients_admin_success_story_data_source.dart';

class AllPatientWithAdminSuccessStoryDataSourceImp implements AllPatientsWithAdminSuccessStoryDataSource{
  final Dio dio;
  AllPatientWithAdminSuccessStoryDataSourceImp(this.dio);
  @override
  Future<Response> getAllPatientsWithAdminSuccessStory(AllPatientModel patientModel) async{
    return await dio.get(
        "/api/pationt-success-story",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}