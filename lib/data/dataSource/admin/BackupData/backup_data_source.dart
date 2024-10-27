import 'package:dio/dio.dart';
abstract class BackupDataSource{
  Future<Response> backupData();
}