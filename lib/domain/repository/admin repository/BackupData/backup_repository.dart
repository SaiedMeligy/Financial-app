import 'package:dio/dio.dart';

abstract class BackupRepository{
  Future<Response> backupData();
}