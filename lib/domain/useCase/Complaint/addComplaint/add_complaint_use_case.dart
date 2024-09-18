import 'package:dio/dio.dart';

import '../../../repository/complaint/AddComplaint/add_complaint_repository.dart';


class AddComplaintUseCase{
  final AddComplaintRepository complaintRepository;
  AddComplaintUseCase(this.complaintRepository);
  Future<Response> execute(String complaint,String nationalID)async{
    return await complaintRepository.addComplaint(complaint,nationalID);
  }
}