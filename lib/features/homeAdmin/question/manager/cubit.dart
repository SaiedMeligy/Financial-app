import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/features/homeAdmin/question/manager/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import '../../../../data/dataSource/addQuestion/store_form_data_source.dart';
import '../../../../data/dataSource/addQuestion/store_form_data_source_imp.dart';
import '../../../../data/repository_imp/add_question_repository_imp.dart';
import '../../../../domain/entities/AdviceMode.dart';
import '../../../../domain/entities/pointerModel.dart';
import '../../../../domain/repository/addQuestion/add_question_repository.dart';
import '../../../../domain/useCase/addQuestion/add_question_use_Case.dart';

class AddQuestionCubit extends Cubit<AddQuestionStates>{
  AddQuestionCubit() : super(LoadingAddQuestionState());
  late AddQuestionUseCase addQuestionUseCase;
  late AddQuestionRepository addQuestionRepository;
  late AddQuestionDataSource dataSource;

  Future<Response> addQuestion(Map<String,dynamic> dataRequest)async{
     WebServices service = WebServices();
    dataSource = AddQuestionDataSourceImp(service.freeDio);
    addQuestionRepository = AddQuestionRepositoryImp(dataSource);
    addQuestionUseCase = AddQuestionUseCase(addQuestionRepository);
    final result = await addQuestionUseCase.execute(dataRequest);
    emit(SuccessAddQuestionState(result));
    return result;
  }



}

