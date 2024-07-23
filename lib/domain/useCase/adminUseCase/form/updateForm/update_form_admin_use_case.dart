import 'package:dio/dio.dart';

import '../../../../repository/admin repository/form/updateFormWithAdmin/update_form_with_admin_repository.dart';

class UpdateFormWithAdminUseCase {
  final UpdateFormWithAdminRepository updateFormRepository;
  UpdateFormWithAdminUseCase(this.updateFormRepository);

  Future<Response> execute(Map<String,dynamic> updateData){
    return updateFormRepository.updateWithAdmin(updateData);
  }
}