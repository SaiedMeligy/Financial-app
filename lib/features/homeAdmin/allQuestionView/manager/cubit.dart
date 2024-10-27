import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/domain/entities/QuestionModel.dart';
import 'package:experts_app/domain/entities/QuestionRelationModel.dart';
import 'package:experts_app/features/homeAdmin/allQuestionView/manager/states.dart';

import '../../../../data/dataSource/question/AllQuestion/all_question_data_source.dart';
import '../../../../data/dataSource/question/AllQuestion/all_question_data_source_imp.dart';
import '../../../../data/dataSource/question/AllQuestionWithoutRelation/all_question_without_relation_data_source.dart';
import '../../../../data/dataSource/question/AllQuestionWithoutRelation/all_question_without_relation_data_source_imp.dart';
import '../../../../data/dataSource/question/deleteQuestion/delete_question_data_source.dart';
import '../../../../data/dataSource/question/deleteQuestion/delete_question_data_source_imp.dart';
import '../../../../data/repository_imp/all_questions_repository_imp.dart';
import '../../../../data/repository_imp/all_questions_without_relation_repository_imp.dart';
import '../../../../data/repository_imp/delete_question_repository_imp.dart';
import '../../../../domain/repository/Question/AllQuestion/all_question_repository.dart';
import '../../../../domain/repository/Question/AllQuestionWithoutRelation/all_question_without_relation_repository.dart';
import '../../../../domain/repository/Question/deleteQuestion/delete_question_repository.dart';
import '../../../../domain/useCase/Question/allQuestion/all_question_use_case.dart';
import '../../../../domain/useCase/Question/allQuestionWithoutRelation/all_question_without_relation_use_case.dart';
import '../../../../domain/useCase/Question/deleteQuestion/delete_question_use_case.dart';

    class AllQuestionCubit extends Cubit<AllQuestionStates> {
      AllQuestionCubit() : super(LoadingAllQuestion());

      late AllQuestionUseCase allQuestionUseCase;
      late AllQuestionRepository allQuestionRepository;
      late AllQuestionDataSource allQuestionDataSource;



    Future<void> getAllQuestion() async {
    WebServices service = WebServices();
    allQuestionDataSource = AllQuestionDataSourceImp(service.freeDio);
      allQuestionRepository = AllQuestionRepositoryImp(allQuestionDataSource);
          allQuestionUseCase = AllQuestionUseCase(allQuestionRepository);
      emit(LoadingAllQuestion());
    try {
        var result = await allQuestionUseCase.execute(QuestionModel());
      print('API Response: ${result.data}');

      final data = QuestionModel.fromJson(result.data);

      if (data != null) {
          emit(SuccessAllQuestion(data.questions!));
      } else {
          emit(ErrorAllQuestion("No consultation services found"));
      }
    } catch (error) {
        emit(ErrorAllQuestion(error.toString()));
    }
  }

      late AllQuestionWithoutRelationUseCase allQuestionWithoutRelationUseCase;
      late AllQuestionWithoutRelationRepository allQuestionWithoutRelationRepository;
      late AllQuestionWithoutRelationDataSource allQuestionWithoutRelationDataSource;



      Future<void> getAllQuestionWithoutRelation() async {
        WebServices service = WebServices();
        allQuestionWithoutRelationDataSource = AllQuestionWithoutRelationDataSourceImp(service.freeDio);
        allQuestionWithoutRelationRepository =
            AllQuestionWithoutRelationRepositoryImp(allQuestionWithoutRelationDataSource);
        allQuestionWithoutRelationUseCase = AllQuestionWithoutRelationUseCase(allQuestionWithoutRelationRepository);
        emit(LoadingAllQuestion());
        try {
          var result = await allQuestionWithoutRelationUseCase.execute(
              QuestionRelationModel());
          print('API Response: ${result.data}');

          final data = QuestionModel.fromJson(result.data);

          if (data != null) {
            emit(SuccessAllQuestion(data.questions!));
          } else {
            emit(ErrorAllQuestion("No Question  found"));
          }
        } catch (error) {
          emit(ErrorAllQuestion(error.toString()));
        }
      }

      late DeleteQuestionUseCase deleteQuestionUseCase;
      late DeleteQuestionRepository deleteQuestionRepository;
      late DeleteQuestionDataSource deleteQuestionDataSource;

      Future<Response> deleteQuestion(int id)async{
        WebServices service = WebServices();
        deleteQuestionDataSource = DeleteQuestionDataSourceImp(service.freeDio);
        deleteQuestionRepository = DeleteQuestionRepositoryImp(deleteQuestionDataSource);
        deleteQuestionUseCase = DeleteQuestionUseCase(deleteQuestionRepository);
        final result = await deleteQuestionUseCase.execute(id);
        emit(SuccessDeleteQuestionState(result));
        return result;
      }




}