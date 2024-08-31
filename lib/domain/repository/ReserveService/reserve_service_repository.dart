import 'package:dio/dio.dart';



abstract class ReserveServiceRepository{
  Future<Response> reserveService(int consultationId,int patientId,String date,String time,int attendType);
}