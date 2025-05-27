import 'package:dio/dio.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/datasource/remote_PointerTypeEvalution_data_source.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/DescImprovement.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/OneSessionPointersEvaluations.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/PointerImprovement.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/SessionPointersEvaluations.dart';
import '../models/AllSessionPointersTypeEvaluation.dart';


class PointerTypeEvalutionRemoteDataSourceImpl implements PointerTypeEvalutionRemoteDataSource{
  final Dio dio;

  PointerTypeEvalutionRemoteDataSourceImpl({required this.dio});

  @override
  Future<OneSessionPointersEvaluations> getEvalutionPointersForSession(Map<String,dynamic> data) async {
    final response = await dio.post(
      '${Constants.baseUrl}/api/PointersEvaluation/getEvalutionPointersForSession',
      data: FormData.fromMap(data),
    );
    return OneSessionPointersEvaluations.fromJson(response.data['data']) ;
  }

  @override
  Future<List<AllSessionPointersTypeEvaluation>> getEvalutionPointersForAllSession(Map<String,dynamic> data) async {
    final response = await dio.post(
      '${Constants.baseUrl}/api/PointersEvaluation/getEvalutionPointersForAllSession' ,
      data: FormData.fromMap(data),
    );
    return (response.data['allSessionPointersEvaluation'] as List).map((e) => AllSessionPointersTypeEvaluation.fromJson(e)).toList();
  }

  @override
  Future<List<DescImprovement>> getDescImprovement(Map<String,dynamic> data) async {
    final response = await dio.post(
      '${Constants.baseUrl}/api/PointersEvaluation/getEvalutionPointersForAllSession' ,
      data: FormData.fromMap(data),
    );
    return (response.data['DescImprovement'] as List).map((e) => DescImprovement.fromJson(e)).toList();
  }

  @override
  Future<List<PointerImprovement>> getPointerImprovement(Map<String,dynamic> data) async {
    final response = await dio.post(
      '${Constants.baseUrl}/api/PointersEvaluation/getEvalutionPointersForAllSession' ,
      data: FormData.fromMap(data),
    );
    return (response.data['PointerImprovement'] as List).map((e) => PointerImprovement.fromJson(e)).toList();
  }

  @override
  Future<String> getPatientName(Map<String,dynamic> data) async {
    final response = await dio.post(
      '${Constants.baseUrl}/api/PointersEvaluation/getEvalutionPointersForAllSession' ,
      data: FormData.fromMap(data),
    );
    return response.data['patientName'];
  }

  @override
  Future<void> editPointerEvaluation(SessionPointersEvaluations sessionPointersEvaluations) async {
    await dio.post(
      '${Constants.baseUrl}/api/PointersEvaluation/editPointerEvaluation',
      data: FormData.fromMap({"id" : sessionPointersEvaluations.id , "evaluation" : sessionPointersEvaluations.evaluation}),
    );
  }

  @override
  Future<void> deletePointerTypes(int id) async {
    await dio.post(
      '${Constants.baseUrl}/api/PointersEvaluation/deletePointerEvaluation',
      data: FormData.fromMap({
        'id': id
      })
    );
  }

  @override
  Future<void> addPointerTypes(Map<String,dynamic> data) async {
    await dio.post(
      '${Constants.baseUrl}/api/PointersEvaluation/addPointersEvaluation',
      data: FormData.fromMap(data),
    );
  }
}