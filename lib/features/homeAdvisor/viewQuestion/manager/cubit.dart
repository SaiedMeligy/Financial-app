import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/data/dataSource/questionView/question_view_data_source_imp.dart';
import 'package:experts_app/data/repository_imp/question_view_repository_imp.dart';
import 'package:experts_app/domain/useCase/quesionView/question_view_use_case.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/states.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/Services/web_services.dart';
import '../../../../data/dataSource/Form/storeForm/store_form_data_source.dart';
import '../../../../data/dataSource/Form/storeForm/store_form_data_source_imp.dart';
import '../../../../data/dataSource/Form/updateForm/update_form_data_source.dart';
import '../../../../data/dataSource/Form/updateForm/update_form_data_source_imp.dart';
import '../../../../data/dataSource/patientNationalId/patient_nationalId_data_source.dart';
import '../../../../data/dataSource/patientNationalId/patient_nationalId_data_source_imp.dart';
import '../../../../data/dataSource/questionView/question_view_data_source.dart';
import '../../../../data/repository_imp/patient_nationalId_repository_imp.dart';
import '../../../../data/repository_imp/store_form_repository_imp.dart';
import '../../../../data/repository_imp/update_form_repository_imp.dart';
import '../../../../domain/entities/QuestionView.dart';
import '../../../../domain/repository/FormRepository/storeForm/store_form_repository.dart';
import '../../../../domain/repository/FormRepository/updateForm/update_form_repository.dart';
import '../../../../domain/repository/patientNationalIdRepository/patient_nationalId_repository.dart';
import '../../../../domain/repository/questionView/view_question_repository.dart';
import '../../../../domain/useCase/Form/storeForm/store_form_use_case.dart';
import '../../../../domain/useCase/Form/updateForm/update_form_use_case.dart';
import '../../../../domain/useCase/patientNationalId/patient_nationalId_use_case.dart';
class QuestionViewCubit extends Cubit<QuestionViewStates> {
  QuestionViewCubit() : super(LoadingQuestionViewState()) {
    date = DateFormat('yyyy-MM-dd').format(selectedDate);
  }

  bool isLoading = true;
  DateTime selectedDate = DateTime.now();
  late String date;

  late QuestionViewUseCase questionViewUseCase;
  late QuestionViewRepository questionViewRepository;
  late QuestionViewDataSource questionViewDataSource;

  Future<void> getAllQuestion() async {
    WebServices service = WebServices();
    questionViewDataSource = QuestionViewDataSourceImp(service.freeDio);
    questionViewRepository = QuestionViewRepositoryImp(questionViewDataSource);
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
    patientNationalIdRepository = PatientNationalIdRepositoryImp(patientNationalIdDataSource);
    patientNationalIdUseCase = PatientNationalIdUseCase(patientNationalIdRepository);
    emit(LoadingQuestionViewState());

    return await patientNationalIdUseCase.execute(nationalId);
  }

  late StoreFormUseCase storeFormUseCase;
  late StoreFormRepository storeFormRepository;
  late StoreFormDataSource storeFormDataSource;

  Future<Response> getStoreForm(Map<String, dynamic> storeData) async {
    WebServices service = WebServices();
    storeFormDataSource = StoreFormDataSourceImp(service.freeDio);
    storeFormRepository = StoreFormRepositoryImp(storeFormDataSource);
    storeFormUseCase = StoreFormUseCase(storeFormRepository);
    // emit(LoadingQuestionViewState());

    return await storeFormUseCase.execute(storeData);
  }

  late UpdateFormUseCase updateFormUseCase;
  late UpdateFormRepository updateFormRepository;
  late UpdateFormDataSource updateFormDataSource;

  Future<Response> getUpdateForm(Map<String, dynamic> updateData) async {
    WebServices service = WebServices();
    updateFormDataSource = UpdateFormDataSourceImp(service.freeDio);
    updateFormRepository = UpdateFormRepositoryImp(updateFormDataSource);
    updateFormUseCase = UpdateFormUseCase(updateFormRepository);
    // emit(LoadingQuestionViewState());

    return await updateFormUseCase.execute(updateData);
  }





  Future<DateTime?> selectTaskDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      emit(QuestionViewDateSelected(selectedDate));
    }
    return picked;
  }
}
