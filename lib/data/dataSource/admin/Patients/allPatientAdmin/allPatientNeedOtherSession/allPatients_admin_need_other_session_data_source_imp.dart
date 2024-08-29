import 'package:dio/dio.dart';
import '../../../../../../core/config/cash_helper.dart';
import '../../../../../../core/config/constants.dart';
import '../../../../../../domain/entities/AllPatientModel.dart';
import 'all_patients_admin_need_other_Session_data_source.dart';

class AllPatientWithAdminNeedOtherSessionDataSourceImp implements AllPatientsWithAdminNeedOtherSessionDataSource{
  final Dio dio;
  AllPatientWithAdminNeedOtherSessionDataSourceImp(this.dio);
  @override
  Future<Response> getAllPatientsWithAdminNeedOtherSession(AllPatientModel patientModel) async{
    return await dio.get(
        "/api/pationt-need-other-session",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}