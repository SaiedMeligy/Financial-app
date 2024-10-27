import 'package:dio/dio.dart';

import '../../../repository/admin repository/BackupData/backup_repository.dart';

class BackupUseCase{
  final BackupRepository backupDataRepository;
  BackupUseCase(this.backupDataRepository);
  Future<Response> execute(){
    return backupDataRepository.backupData();
  }

}