import 'package:dio/dio.dart';

abstract class BackupStates{}
class LoadingBackupState extends BackupStates{}
class SuccessBackupState extends BackupStates{
  final Response response;
  SuccessBackupState(this.response);
}
class ErrorBackupState extends BackupStates{
  final String errorMessage;
  ErrorBackupState({required this.errorMessage});
}
