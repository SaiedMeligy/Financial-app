import 'package:dio/dio.dart';

import '../../repository/ReserveService/reserve_service_repository.dart';




class ReserveServiceUseCase{
  final ReserveServiceRepository reserveServiceRepository;
  ReserveServiceUseCase(this.reserveServiceRepository);

  Future<Response> execute(int consultationId,int patientId,String date,String time, int attendType)async{

    return await reserveServiceRepository.reserveService(consultationId,patientId,date,time,attendType);
  }
}