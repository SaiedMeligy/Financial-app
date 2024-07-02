import 'package:dio/dio.dart';

import '../../../../repository/admin repository/form/updateForm/update_form_repository.dart';

class UpdateFormWithAdminUseCase {
  final UpdateFormWithAdminRepository updateFormRepository;
  UpdateFormWithAdminUseCase(this.updateFormRepository);

  Future<Response> execute(Map<String,dynamic> updateData){
    return updateFormRepository.updateWithAdmin(updateData);
  }
}