import 'package:dio/dio.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/data/datasources/remote_pointerType_data_source.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/data/models/PointerTypeModel.dart';

class PointerTypeRemoteDataSourceImpl implements PointerTypeRemoteDataSource {
  final Dio dio;

  PointerTypeRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PointerTypeModel>> getAllPointerTypes() async {
    final response = await dio.get('${Constants.baseUrl}/api/pointerType/allPointersType');
    return (response.data['data'] as List).map((e) => PointerTypeModel.fromJson(e)).toList();
  }

  @override
  Future<void> updatePointerTypes(PointerTypeModel pointerType) async {
    await dio.post(
      '${Constants.baseUrl}/api/pointerType/editPointerType',
      data: FormData.fromMap(pointerType.toJson()),
    );
  }

  @override
  Future<void> deletePointerTypes(int id) async {
    await dio.post(
      '${Constants.baseUrl}/api/pointerType/deletePointerType',
      data: FormData.fromMap({
        'id': id
      })
    ).then((value) {
      print("==========================) ${value.data.toString()} == ) $id");
    },);


  }

  @override
  Future<void> addPointerTypes(PointerTypeModel pointerType) async {
    await dio.post(
      '${Constants.baseUrl}/api/pointerType/insertPointerType',
      data: FormData.fromMap(pointerType.toJson()),
    );
  }
}
