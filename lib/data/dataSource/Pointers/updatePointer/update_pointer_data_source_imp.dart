import 'package:dio/dio.dart';
import 'package:experts_app/data/dataSource/Pointers/updatePointer/update_pointer_data_source.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';

class UpdatePointerDataSourceImp implements UpdatePointerDataSource{
  final Dio dio;
  UpdatePointerDataSourceImp(this.dio);
  @override
  Future<Response> updatePointer(int id,String title) async{
    return await dio.patch(
      "/api/pointer/update",
      options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token": CacheHelper.getData(key: "token")
          },
      ),
      queryParameters: {
        "id":id,
        "text":title,
      }

      );


  }

}