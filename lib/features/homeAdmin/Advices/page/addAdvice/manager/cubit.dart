import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/web_services.dart';

import 'package:experts_app/data/repository_imp/add_advice_repository_imp.dart';
import 'package:experts_app/features/homeAdmin/Advices/page/addAdvice/manager/states.dart';

import '../../../../../../data/dataSource/Advices/addAdvice/add_advice_data_source.dart';
import '../../../../../../data/dataSource/Advices/addAdvice/add_advice_data_source_imp.dart';
import '../../../../../../domain/repository/advices/addAdvice/add_advice_repository.dart';
import '../../../../../../domain/useCase/advices/addAdvice/add_Advice_use_case.dart';


class AddAdviceCubit extends Cubit<AddAdviceState>{
  AddAdviceCubit() : super(LoadingAddAdviceState());
  late AddAdviceUseCase addAdviceUseCase;
  late AddAdviceRepository adviceRepository;
  late AddAdviceDataSource addAdviceDataSource;


  Future<Response> addAdvice(String advice)async{
    WebServices services = WebServices();
    addAdviceDataSource = AddAdviceDataSourceImp(services.freeDio);
    adviceRepository = AddAdviceRepositoryImp(addAdviceDataSource);
    addAdviceUseCase = AddAdviceUseCase(adviceRepository);

    return await addAdviceUseCase.execute(advice);

  }

}