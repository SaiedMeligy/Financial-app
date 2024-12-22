import 'package:bloc/bloc.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/manager/states.dart';
import '../../../../data/dataSource/allPatient/allPatients_data_source_imp.dart';
import '../../../../data/dataSource/allPatient/all_patients_data_source.dart';
import '../../../../data/repository_imp/all_patient_repository_imp.dart';
import '../../../../domain/repository/AllPatient/all_patient_repository.dart';
import '../../../../domain/useCase/allpatient/all_patient_use_case.dart';

// class AllPatientCubit extends Cubit<AllPatientStates> {
//   int currentPage = 1;
//   bool isLastPage = false;
//   List<Pationts> patients = [];
//
//   AllPatientCubit() : super(LoadingAllPatient());
//
//   late AllPatientUseCase allPatientUseCase;
//   late AllPatientRepository allPatientRepository;
//   late AllPatientsDataSource allPatientDataSource;
//
//   Future<void> getAllPatient({bool loadMore = false}) async {
//     if (isLastPage && loadMore) return;
//     WebServices service = WebServices();
//     allPatientDataSource = AllPatientDataSourceImp(service.freeDio);
//     allPatientRepository = AllPatientRepositoryImp(allPatientDataSource);
//     allPatientUseCase = AllPatientUseCase(allPatientRepository);
//     emit(LoadingAllPatient());
//     try {
//       var result = await allPatientUseCase.execute(AllPatientModel(),page: currentPage);
//       print('API Response: ${result.data}');
//
//       final data = AllPatientModel.fromJson(result.data);
//       if(data.pationts!.isEmpty){
//         isLastPage = true;
//       }
//       else {
//         currentPage++;
//         patients.addAll(data.pationts??[]);
//       }
//       emit(SuccessAllPatient(data.pationts ?? []));
//     } catch (error) {
//       emit(ErrorAllPatient(error.toString()));
//     }
//   }
//
// }

class AllPatientCubit extends Cubit<AllPatientStates> {
  int currentPage = 1;
  bool isLastPage = false;
  bool isLoading = false;
  String currentSearchQuery = '';
  List<Pationts> patients = [];

  AllPatientCubit() : super(LoadingAllPatient());

  late AllPatientUseCase allPatientUseCase;
  late AllPatientRepository allPatientRepository;
  late AllPatientsDataSource allPatientDataSource;

  Future<void> getAllPatient({bool loadMore = false ,String? searchQuery}) async {
    if(searchQuery!=null && !loadMore){
      if(searchQuery == currentSearchQuery)return;
      isLastPage = false;
      currentPage=1;
      currentSearchQuery=searchQuery;
      patients = [];
    }
    if(isLastPage||isLoading) return;

    isLoading = true;
    WebServices service = WebServices();
    allPatientDataSource = AllPatientDataSourceImp(service.freeDio);
    allPatientRepository = AllPatientRepositoryImp(allPatientDataSource);
    allPatientUseCase = AllPatientUseCase(allPatientRepository);

    if (!loadMore) emit(LoadingAllPatient());

    try {
      var result = await allPatientUseCase.execute(AllPatientModel(), page: currentPage,searchQuery: currentSearchQuery);
      final data = AllPatientModel.fromJson(result.data);

      if (data.pationts!.isEmpty) {
        isLastPage = true;
      }
      else {
        currentPage++;
        patients.addAll(data.pationts ?? []);
      }

      emit(SuccessAllPatient(patients));
    } catch (error) {
      emit(ErrorAllPatient(error.toString()));
    } finally {
      isLoading = false;
    }
  }
  void updatePatientLocally(Pationts updatedPatient) {
    final index = patients.indexWhere((p) => p.id == updatedPatient.id);
    if (index != -1) {
      patients[index] = updatedPatient;
      emit(SuccessAllPatient( patients));
    }
  }
}

  // Function to remove a patient from the local list and update state
  // void removePatientFromList(Pationts patient) {
  //   patients.removeWhere((p) => p.id == patient.id);
  //   emit(SuccessAllPatient(patients));
  // }
