import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import '../../../../domain/entities/AllPatientModel.dart';
import 'all_patients_data_source.dart';

class AllPatientRecycleDataSourceImp implements AllPatientsRecycleDataSource{
  final Dio dio;
  AllPatientRecycleDataSourceImp(this.dio);
  @override
  Future<Response> getAllPatientsRecycle(AllPatientModel patientModel,int recycle,{int page =1,int per_page= 20}) async{
    return await dio.get(
        "/api/advicor/pationt",

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