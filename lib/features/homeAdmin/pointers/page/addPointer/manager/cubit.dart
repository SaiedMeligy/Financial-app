import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/features/homeAdmin/pointers/page/addPointer/manager/states.dart';

import '../../../../../../core/Services/web_services.dart';
import '../../../../../../data/dataSource/Pointers/addPointer/add_pointer_data_source.dart';
import '../../../../../../data/dataSource/Pointers/addPointer/add_pointer_data_source_imp.dart';
import '../../../../../../data/repository_imp/add_pointer_repository_imp.dart';
import '../../../../../../domain/repository/pointer/addPointer/add_pointer_repository.dart';
import '../../../../../../domain/useCase/Pointers/addpointer/add_pointer_use_case.dart';

class AddPointerCubit extends Cubit<AddPointerStates>{
  AddPointerCubit() : super(LoadingAddPointerStates());

  late AddPointerUseCase addPointerUseCase;
  late AddPointerRepository adviceRepository;
  late AddPointerDataSource addPointerDataSource;


  Future<Response> addPointer(int senarioId,String title)async{
    WebServices services = WebServices();
    addPointerDataSource = AddPointerDataSourceImp(services.freeDio);
    adviceRepository = AddPointerRepositoryImp(addPointerDataSource);
    addPointerUseCase = AddPointerUseCase(adviceRepository);

    return await addPointerUseCase.execute(senarioId,title);

  }


}