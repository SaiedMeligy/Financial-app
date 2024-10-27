import 'package:dio/dio.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'backup_data_source.dart';


class BackupDataSourceImp implements BackupDataSource{
  final Dio dio;
  BackupDataSourceImp(this.dio);

  @override
  Future<Response> backupData() async{
    return await dio.get(
      "/api/backup-database",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )

    );
  }

}