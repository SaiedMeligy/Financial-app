

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Services/snack_bar_service.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../domain/entities/AllPatientModel.dart';
import '../../../homeAdmin/allPatientsAdmin/manager/cubit.dart';
import '../../../homeAdmin/allPatientsAdmin/manager/states.dart';
import '../widget/patient_widget_view_with_abozaby.dart';

class AllPatientAbozabyView extends StatefulWidget {
  const AllPatientAbozabyView({super.key});

  @override
  State<AllPatientAbozabyView> createState() => _AllPatientAbozabyViewState();
}

class _AllPatientAbozabyViewState extends State<AllPatientAbozabyView> {
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
                  opacity: 0.2
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
                  PatientWidgetViewWithAbozaby<Pationts>(
                    label1: "اسم الحالة",
                    items: filteredPatients,
                    itemNameBuilder: (item) => item.name ?? 'No Name',

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

