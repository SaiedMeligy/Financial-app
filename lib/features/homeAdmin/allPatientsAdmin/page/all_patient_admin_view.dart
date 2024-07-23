import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/updatePatient/page/dialog_delete_patient_withAdmin.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/updatePatient/page/dialog_edit_patient_WithAdmin.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/widget/patient_widget_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../domain/entities/AllPatientModel.dart';
import '../manager/cubit.dart';
import '../manager/states.dart';

class AllPatientAdminView extends StatefulWidget {
  const AllPatientAdminView({super.key});

  @override
  State<AllPatientAdminView> createState() => _AllPatientAdminViewState();
}

class _AllPatientAdminViewState extends State<AllPatientAdminView> {
  late AllPatientWithAdminCubit allPatientCubit;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    allPatientCubit = AllPatientWithAdminCubit();
    allPatientCubit.getAllPatientWithAdmin();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllPatientWithAdminCubit, AllPatientWithAdminStates>(
      bloc: allPatientCubit,
      builder: (context, state) {
        if (state is LoadingAllPatientWithAdmin) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (state is SuccessAllPatientWithAdmin) {
          var patients = state.patients;

          var filteredPatients = patients.where((patient) {
            return patient.name != null && patient.name!.contains(searchQuery);
          }).toList();

          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/back.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.8
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CustomTextField(
                    controller: searchController,
                    hint: "البحث",
                    icon: Icons.search,
                  ),
                  const SizedBox(height: 10),
                  PatientWidgetViewWithAdmin<Pationts>(
                    label1: "اسم الحالة",
                    label2: "التعديل",
                    label3: "الحذف",
                    items: filteredPatients,
                    itemNameBuilder: (item) => item.name ?? 'No Name',
                    itemEditWidgetBuilder: (item) => DialogEditPatientWithAdmin(
                      allPatientCubit: allPatientCubit,
                      patient: item,
                    ),
                    itemDeleteWidgetBuilder: (item) {
                      if (item == null) {
                        return const Text("Invalid Item");
                      }
                      return DialogDeletePatientWithAdmin(
                        allPatientCubit: allPatientCubit,
                        patient: item,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        else if (state is ErrorAllPatientWithAdmin) {
          SnackBarService.showErrorMessage(state.errorMessage);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

