import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import '../../../domain/entities/AllPatientModel.dart';
import 'all_patients_data_source.dart';

class AllPatientDataSourceImp implements AllPatientsDataSource{
  final Dio dio;
  AllPatientDataSourceImp(this.dio);

  @override
  Future<Response> getAllPatients(AllPatientModel patientModel, {int page = 1,int per_page = 20}) async{
    return await dio.get(
        "/api/advicor/pationt",
        queryParameters: {
          "page":page,
          "per_page":per_page },
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        ),

    );

  }

}