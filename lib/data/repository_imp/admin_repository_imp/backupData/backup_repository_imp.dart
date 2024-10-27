import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/data/dataSource/admin/BackupData/backup_data_source.dart';
import 'package:experts_app/domain/repository/admin%20repository/BackupData/backup_repository.dart';

class BackupRepositoryImp implements BackupRepository{
  final BackupDataSource backupDataSource;
  BackupRepositoryImp({required this.backupDataSource});
  @override
  Future<Response> backupData() async {
    try {
      final response = await backupDataSource.backupData();
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response;
        }
        else{
          throw ServerFailure(statusCode: response.statusCode.toString(),
              message: response.data["message"] ?? "unKnown error"
          );
        }
      }
      else {
        return throw ServerFailure(statusCode: response.statusCode.toString(),
            message: response.data["message"] ?? "unKnown error"
        );
      }
    }
    on DioException catch (exception) {
      return throw ServerFailure(
          statusCode: exception.response?.statusCode.toString()??"", message: exception.response?.data["message"]??"server error");
    }
  }

}