import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/features/homeAdmin/question/manager/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import '../../../../data/dataSource/addQuestion/add_question_data_source.dart';
import '../../../../data/dataSource/addQuestion/add_question_data_source_imp.dart';
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
  // static AddQuestionCubit get(context) => BlocProvider.of(context);
  //
  // List<Pointers> pointers1 = [];
  // List<Pointers> pointers2 = [];
  // List<Pointers> pointers3 = [];
  // List<Advices> advices = [];
  //
  // Future<void> fetchPointers() async {
  //   emit(LoadingAddQuestionState());
  //   final dio = Dio();
  //   try {
  //     final response = await dio.get(
  //       '${Constants.baseUrl}/api/pointer',
  //       options: Options(headers: {
  //         "api-password": Constants.apiPassword,
  //         "token": CacheHelper.getData(key: "token")
  //       }),
  //     );
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = response.data["pointers"];
  //       List<Pointers> pointers = data.map((json) => Pointers.fromJson(json)).toList();
  //
  //       pointers1 = pointers.where((pointer) => pointer.senarioId == 1).toList();
  //       pointers2 = pointers.where((pointer) => pointer.senarioId == 2).toList();
  //       pointers3 = pointers.where((pointer) => pointer.senarioId == 3).toList();
  //
  //       emit(AddQuestionLoadedState());
  //     } else {
  //       emit(ErrorAddQuestionState('Failed to load pointers. Status code: ${response.statusCode}'));
  //     }
  //   } catch (e) {
  //     emit(ErrorAddQuestionState('Error occurred: $e'));
  //   }
  // }
  //
  // Future<void> fetchAdvices() async {
  //   emit(LoadingAddQuestionState());
  //   final dio = Dio();
  //   try {
  //     final response = await dio.get(
  //       '${Constants.baseUrl}/api/advice',
  //       options: Options(headers: {
  //         "api-password": Constants.apiPassword,
  //         "token": CacheHelper.getData(key: "token")
  //       }),
  //     );
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = response.data["advices"];
  //       advices = data.map((json) => Advices.fromJson(json)).toList();
  //       emit(AddQuestionLoadedState());
  //     } else {
  //       emit(ErrorAddQuestionState('Failed to load advices. Status code: ${response.statusCode}'));
  //     }
  //   } catch (e) {
  //     emit(ErrorAddQuestionState('Error occurred: $e'));
  //   }
  // }

  // void addQuestion(Map<String, dynamic> requestData) {
  //   // Handle adding question logic here
  //   emit(SuccessAddQuestionState());
  // }
}