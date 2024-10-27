import 'package:bloc/bloc.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/data/dataSource/admin/BackupData/backup_data_source_imp.dart';
import 'package:experts_app/data/repository_imp/admin_repository_imp/backupData/backup_repository_imp.dart';
import 'package:experts_app/domain/useCase/adminUseCase/BackupUseCase/backup_use_Case.dart';
import 'package:experts_app/features/homeAdmin/Backup_data/manager/states.dart';

import '../../../../data/dataSource/admin/BackupData/backup_data_source.dart';
import '../../../../domain/repository/admin repository/BackupData/backup_repository.dart';

class BackupCubit extends Cubit<BackupStates>{
  BackupCubit() : super(LoadingBackupState());

   late BackupUseCase backupUseCase;
   late BackupRepository backupDataRepository;
   late BackupDataSource backupDataSource;


  void getBackupData() async{
    WebServices dio = WebServices();
    backupDataSource = BackupDataSourceImp(dio.freeDio);
    backupDataRepository = BackupRepositoryImp(backupDataSource: backupDataSource);
    backupUseCase =BackupUseCase(backupDataRepository);
    emit(LoadingBackupState());
    try {
      var result = await backupUseCase.execute();
      emit(SuccessBackupState(result.data));
    }
    catch (error) {
      emit(ErrorBackupState(errorMessage: error.toString()));
    }



  }

}