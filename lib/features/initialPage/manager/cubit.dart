import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/features/initialPage/manager/states.dart';

import '../../../data/dataSource/complaint/addcomplaint/add_complaint_data_source.dart';
import '../../../data/dataSource/complaint/addcomplaint/add_complaint_data_source_imp.dart';
import '../../../data/repository_imp/add_complaint_repository_imp.dart';
import '../../../domain/repository/complaint/AddComplaint/add_complaint_repository.dart';
import '../../../domain/useCase/Complaint/addComplaint/add_complaint_use_case.dart';



class AddComplaintCubit extends Cubit<AddComplaintState>{
  AddComplaintCubit() : super(LoadingAddComplaintState());
  late AddComplaintUseCase addComplaintUseCase;
  late AddComplaintRepository complaintRepository;
  late AddComplaintDataSource addComplaintDataSource;


  Future<Response> addComplaint(String complaint,String nationalID)async{
    WebServices services = WebServices();
    addComplaintDataSource = AddComplaintDataSourceImp(services.freeDio);
    complaintRepository = AddComplaintRepositoryImp(addComplaintDataSource);
    addComplaintUseCase = AddComplaintUseCase(complaintRepository);

    return await addComplaintUseCase.execute(complaint,nationalID);

  }

}