import 'package:dio/dio.dart';

import '../../../repository/FormRepository/updateForm/update_form_repository.dart';

class UpdateFormUseCase {
  final UpdateFormRepository updateFormRepository;
  UpdateFormUseCase(this.updateFormRepository);

  Future<Response> execute(Map<String,dynamic> updateData){
    return updateFormRepository.update(updateData);
  }
}