import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/failure.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/data/datasource/QuestionStatisticsDatasource.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/data/models/QuestionStatisticsModel.dart';

class Questionstatisticsdatasourceimpl implements Questionstatisticsdatasource{
  final Dio dio ;
  Questionstatisticsdatasourceimpl(this.dio);

  @override
  Future<Either<Failure , QuestionStatisticsModel>> getQuestionStatistics(String text) async {
    try{
      final response = await dio.post(
        "${Constants.baseUrl}/api/statistics/answersStatistics" ,
        data: FormData.fromMap({
          'text': text
        }),
      );
      if(!response.data["success"]) {
        return Left(ServerFailure(message: response.data["message"].toString(), statusCode: '400'));
      }

      final parsed = QuestionStatisticsModel.fromJson(response.data["data"]) ;

      return Right(parsed);
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message.toString(), statusCode: '400'));
    } catch(e){
      return Left(ServerFailure(message: e.toString(), statusCode: '400'));
    }
  }
}