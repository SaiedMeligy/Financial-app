import 'package:dio/dio.dart';

import '../../repository/AddService/add_service_repository.dart';



class AddServiceUseCase{
  final AddServiceRepository addServiceRepository;
  AddServiceUseCase(this.addServiceRepository);

  Future<Response> execute(String description)async{

    return await addServiceRepository.addService(description);
  }
}