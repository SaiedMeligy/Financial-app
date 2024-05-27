import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import '../../../../core/Services/web_services.dart';
import '../../../../domain/entities/QuestionView.dart';
import 'package:experts_app/features/login/manager/cubit.dart';
import '../../../../domain/useCase/storeForm/store_form_use_case.dart';
import '../../../../data/repository_imp/store_form_repository_imp.dart';
import '../../../../data/dataSource/storeForm/store_form_data_source.dart';
import '../../../../domain/repository/storeForm/store_form_repository.dart';
import '../../../../data/dataSource/storeForm/store_form_data_source_imp.dart';
import '../../../../data/repository_imp/patient_nationalId_repository_imp.dart';
import '../../../../data/dataSource/questionView/question_view_data_source.dart';
import '../../../../domain/repository/questionView/view_question_repository.dart';
import 'package:experts_app/data/repository_imp/question_view_repository_imp.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/states.dart';
import 'package:experts_app/domain/useCase/quesionView/question_view_use_case.dart';
import '../../../../domain/useCase/patientNationalId/patient_nationalId_use_case.dart';
import '../../../../data/dataSource/patientNationalId/patient_nationalId_data_source.dart';
import 'package:experts_app/data/dataSource/questionView/question_view_data_source_imp.dart';
import '../../../../data/dataSource/patientNationalId/patient_nationalId_data_source_imp.dart';
import '../../../../domain/repository/patientNationalIdRepository/patient_nationalId_repository.dart';


class QuestionViewCubit extends Cubit<QuestionViewStates>{
  QuestionViewCubit() : super(LoadingQuestionViewState());
  bool isLoading = true;

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
      var result = await questionViewUseCase.execute(QuestionView());
      isLoading = false;
      print('API Response: ${result.data}');

      final data = QuestionView.fromJson(result.data);
      emit(SuccessQuestionViewState(data.questions!));
        } catch (error) {
      emit(ErrorQuestionViewState(error.toString()));
    }
  }

  late PatientNationalIdUseCase patientNationalIdUseCase;
  late PatientNationalIdRepository patientNationalIdRepository;
  late PatientNationalIdDataSource patientNationalIdDataSource;

  Future<Response> getPatientNationalId(String nationalId) async {
    WebServices service = WebServices();
    patientNationalIdDataSource = PatientNationalIdDataSourceImp(service.freeDio);
    patientNationalIdRepository = PatientNationalIdRepositoryImp( patientNationalIdDataSource);
    patientNationalIdUseCase = PatientNationalIdUseCase(patientNationalIdRepository);
    emit(LoadingQuestionViewState());

       return await patientNationalIdUseCase.execute(nationalId);

   }



  late StoreFormUseCase storeFormUseCase;
  late StoreFormRepository storeFormRepository;
  late StoreFormDataSource storeFormDataSource;

    Future<Response> getStoreForm(Map<String,dynamic> storeData) async {
    WebServices service = WebServices();
    storeFormDataSource = StoreFormDataSourceImp(service.freeDio);
    storeFormRepository = StoreFormRepositoryImp( storeFormDataSource);
    storeFormUseCase = StoreFormUseCase(storeFormRepository);
    emit(LoadingQuestionViewState());
    return await storeFormUseCase.execute(storeData);

  }



}