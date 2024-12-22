import 'package:dio/dio.dart';
import 'package:experts_app/core/config/cash_helper.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/domain/entities/SessionUpdateModel.dart';
import 'update_session_data_source.dart';

class UpdateSessionDataSourceImp implements UpdateSessionDataSource{
  final Dio dio;
  UpdateSessionDataSourceImp(this.dio);
  @override
  Future<Response> updateSession(SessionsUpdateModel data) async{
    return await dio.patch(
      "/api/advicor/session/update",
      options: Options(
        headers: {
          "api-password":Constants.apiPassword,
          "token":CacheHelper.getData(key: "token")
        },


      ),
      queryParameters: {
        "id":data.sessionId,
        "advicor_comments":data.comments,
        "consultation_service_id":data.consultationId,
        "is_attended":data.isAttend,
        "need_other_session":data.needOtherSession,
        "is_success_story":data.isSuccessStory,
        "is_finished":data.isFinished,
        "phone_number":data.phoneNumber,
        'other_phone_number':data.otherPhoneNumber,
        'case_manager':data.caseManager
      },

    );

  }

}