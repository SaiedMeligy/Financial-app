import 'package:dio/dio.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/data/datasources/remote_pointerType_data_source.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/data/models/PointerTypeModel.dart';

class PointerTypeRemoteDataSourceImpl implements PointerTypeRemoteDataSource {
  final Dio dio;

  PointerTypeRemoteDataSourceImpl({required this.dio});

  static const baseUrl = 'http://127.0.0.1:8000/api/pointerType';
  //static const baseUrl = 'https://financialclinic.site/financial_clinic_apis/public/api/pointerType';

  @override
  Future<List<PointerTypeModel>> getAllPointerTypes() async {
    final response = await dio.get('$baseUrl/allPointersType');
    return (response.data['data'] as List).map((e) => PointerTypeModel.fromJson(e)).toList();
  }

  @override
  Future<void> updatePointerTypes(PointerTypeModel pointerType) async {
    print('=========================================== ${pointerType.toJson()}');
    await dio.post(
      '$baseUrl/editPointerType',
      data: FormData.fromMap(pointerType.toJson()),
    );
  }

  @override
  Future<void> deletePointerTypes(int id) async {
    await dio.post(
      '$baseUrl/deletePointerType',
      data: FormData.fromMap({
        'id': id
      })
    );
  }

  @override
  Future<void> addPointerTypes(PointerTypeModel pointerType) async {
    await dio.post(
      '$baseUrl/insertPointerType',
      data: FormData.fromMap(pointerType.toJson()),
    );
  }
}
