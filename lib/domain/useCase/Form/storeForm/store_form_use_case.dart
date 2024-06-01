import 'package:dio/dio.dart';

import '../../../repository/FormRepository/storeForm/store_form_repository.dart';

class StoreFormUseCase {
  final StoreFormRepository storeFormRepository;
  StoreFormUseCase(this.storeFormRepository);

  Future<Response> execute(Map<String,dynamic> storeData){
    return storeFormRepository.store(storeData);
  }
}