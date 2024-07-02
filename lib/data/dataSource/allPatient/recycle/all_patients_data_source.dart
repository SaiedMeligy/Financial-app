import 'package:dio/dio.dart';

import '../../../../domain/entities/AllPatientModel.dart';


abstract class AllPatientsRecycleDataSource {

  Future<Response> getAllPatientsRecycle(AllPatientModel patientModel,int recycle);
}