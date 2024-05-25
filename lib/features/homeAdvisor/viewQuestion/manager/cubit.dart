import 'package:bloc/bloc.dart';
import 'package:experts_app/data/dataSource/questionView/question_view_data_source_imp.dart';
import 'package:experts_app/data/repository_imp/question_view_repository_imp.dart';
import 'package:experts_app/domain/useCase/quesionView/question_view_use_case.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/states.dart';

import '../../../../core/Services/web_services.dart';
import '../../../../data/dataSource/questionView/question_view_data_source.dart';
import '../../../../domain/entities/QuestionView.dart';
import '../../../../domain/repository/questionView/view_question_repository.dart';

class QuestionViewCubit extends Cubit<QuestionViewStates>{
  QuestionViewCubit() : super(LoadingQuestionViewState());

  late QuestionViewUseCase questionViewUseCase;
  late QuestionViewRepository questionViewRepository;
  late QuestionViewDataSource questionViewDataSource;

  Future<void> getAllQuestion() async {
    WebServices service = WebServices();
    questionViewDataSource = QuestionViewDataSourceImp(service.freeDio);
    questionViewRepository = QuestionViewRepositoryImp( questionViewDataSource);
    questionViewUseCase = QuestionViewUseCase(questionViewRepository);
    emit(LoadingQuestionViewState());
    try {
      var result = await questionViewUseCase.execute(
          QuestionView());
      print('API Response: ${result.data}');

      final data = QuestionView.fromJson(result.data);
      if (data != null) {
        emit(SuccessQuestionViewState(data.questions!));
      } else {
        emit(ErrorQuestionViewState("No questions found"));
      }
    } catch (error) {
      emit(ErrorQuestionViewState(error.toString()));
    }
  }
}