// import 'package:dio/dio.dart';
//
// import 'all_session_evaluation_data_source.dart';
//
// class AllSessionEvaluationDataSourceImp implements AllSessionEvaluationDataSource{
//   final Dio dio;
//   AllSessionEvaluationDataSourceImp(this.dio);
//   @override
//   Future<Response> getAllSessionEvaluation(List<int>sessionIds) async{
//     return await dio.post(
//         "/api/PointersEvaluation/getEvalution,
//         queryParameters: {
//           "page": page,
//           "per_page": per_page,
//           "searchQuery":searchQuery
//         },
//         options: Options(
//             headers: {
//               "api-password": Constants.apiPassword,
//               "token": CacheHelper.getData(key: "token")
//             }
//         )
//     );
//
//   }
//
// }