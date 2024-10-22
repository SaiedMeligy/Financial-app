import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import '../../../../../../core/config/cash_helper.dart';
import '../../../../../../core/config/constants.dart';
import '../../../../../../domain/entities/AllPatientModel.dart';
import 'all_patients_admin_data_source.dart';

class AllPatientRecycleWithAdminDataSourceImp implements AllPatientsRecycleWithAdminDataSource{
  final Dio dio;
  AllPatientRecycleWithAdminDataSourceImp(this.dio);
  @override
  Future<Response> getAllPatientsRecycleWithAdmin(AllPatientModel patientModel,int recycle,{int page = 1,int per_page=20}) async{
    return await dio.get(
        "/api/pationt",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        ),
      queryParameters:{
          "recycle_bin":recycle,
        "page": page,
        "per_page": per_page,
      }
    );

  }

}