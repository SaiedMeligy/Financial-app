import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/Failure/failure.dart';
import '../../../../core/Failure/server_failure.dart';
import '../../../../core/Services/snack_bar_service.dart';
import '../../../../domain/entities/RegisterPatient.dart';
import '../../../../domain/repository/admin repository/patiens/registerPatientWithAdmin/repository_register_patient_admin.dart';
import '../../../dataSource/admin/Patients/registerPationtAdmin/register_pationt_admin_data_source.dart';



class RegisterPatientWithAdminRepositoryImp implements RepositoryRegisterPatientWithAdmin{
  final RegisterPatientWithAdminDataSource registerDataSource;
  RegisterPatientWithAdminRepositoryImp(this.registerDataSource);
  @override
  Future<Either<Failure, bool>> registerWithAdmin(RegisterPatientDataRequest data) async{
    try {
      final response = await registerDataSource.registerWithAdmin(data);
      if(response.statusCode ==200){
        if (response.data["status"] == true) {
          SnackBarService.showSuccessMessage(response.data["message"]);

          return Right(true);
        }
        else{
          print("data false");
          SnackBarService.showErrorMessage(response.data["message"]);
          return Left(ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data["message"],

          ));
        }


      }

      else{
        return Left(ServerFailure(
          statusCode: response.statusCode.toString(),
          message: response.data["message"],
        ));
      }
    }on DioException catch (error){
      return Left(ServerFailure(
        statusCode: error.response?.statusCode.toString()??"",
        message: error.response?.data["message"],
      ));
    }
  }

}