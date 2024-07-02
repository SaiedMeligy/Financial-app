import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/features/homeAdmin/question/manager/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/dataSource/question/addQuestion/store_form_data_source.dart';
import '../../../../data/dataSource/question/addQuestion/store_form_data_source_imp.dart';
import '../../../../data/dataSource/question/updateQuestion/update_form_data_source.dart';
import '../../../../data/dataSource/question/updateQuestion/update_form_data_source_imp.dart';
import '../../../../data/repository_imp/add_question_repository_imp.dart';
import '../../../../data/repository_imp/update_question_repository_imp.dart';
import '../../../../domain/repository/Question/addQuestion/add_question_repository.dart';
import '../../../../domain/repository/Question/updateQuestion/update_question_repository.dart';
import '../../../../domain/useCase/Question/addQuestion/add_question_use_Case.dart';
import '../../../../domain/useCase/Question/updateQuestion/update_question_use_Case.dart';

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

  late UpdateQuestionUseCase updateQuestionUseCase;
  late UpdateQuestionRepository updateQuestionRepository;
  late UpdateQuestionDataSource updateDataSource;

  Future<Response> updateQuestion(Map<String,dynamic> dataRequest)async{
    WebServices service = WebServices();
    updateDataSource = UpdateQuestionDataSourceImp(service.freeDio);
    updateQuestionRepository = UpdateQuestionRepositoryImp(updateDataSource);
    updateQuestionUseCase = UpdateQuestionUseCase(updateQuestionRepository);
    final result = await updateQuestionUseCase.execute(dataRequest);
    emit(SuccessUpdateQuestionState(result));
    return result;
  }


}

