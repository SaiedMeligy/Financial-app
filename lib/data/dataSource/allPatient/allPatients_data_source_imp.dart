import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/domain/entities/AdviceMode.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'all_patients_data_source.dart';

class AllPatientDataSourceImp implements AllPatientsDataSource{
  final Dio dio;
  AllPatientDataSourceImp(this.dio);
  @override
  Future<Response> getAllPatients(AllPatientModel patientModel) async{
    return await dio.get(
        "/api/advicor/pationt",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}