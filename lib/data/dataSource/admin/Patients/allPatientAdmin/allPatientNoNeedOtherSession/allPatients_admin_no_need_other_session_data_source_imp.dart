import 'package:dio/dio.dart';
import '../../../../../../core/config/cash_helper.dart';
import '../../../../../../core/config/constants.dart';
import '../../../../../../domain/entities/AllPatientModel.dart';
import 'all_patients_admin_no_need_other_Session_data_source.dart';

class AllPatientWithAdminNoNeedOtherSessionDataSourceImp implements AllPatientsWithAdminNoNeedOtherSessionDataSource{
  final Dio dio;
  AllPatientWithAdminNoNeedOtherSessionDataSourceImp(this.dio);
  @override
  Future<Response> getAllPatientsWithAdminNoNeedOtherSession(AllPatientModel patientModel) async{
    return await dio.get(
        "/api/pationt-no-need-other-session",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}