import 'package:experts_app/domain/entities/AllPatientModel.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/updatePatient/page/dialog_delete_patient.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/updatePatient/page/dialog_edit_patient.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/widget/patient_widget_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widget/custom_text_field.dart';

class AllPatientView extends StatefulWidget {
  const AllPatientView({super.key});

  @override
  State<AllPatientView> createState() => _AllPatientViewState();
}

class _AllPatientViewState extends State<AllPatientView> {
  late AllPatientCubit allPatientCubit;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    allPatientCubit = AllPatientCubit();
    allPatientCubit.getAllPatient();

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
    return BlocBuilder<AllPatientCubit, AllPatientStates>(
      bloc: allPatientCubit,
      builder: (context, state) {
        if (state is LoadingAllPatient) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessAllPatient) {
          var patients = state.patients;

          var filteredPatients = patients.where((patient) {
            return patient.name != null && patient.name!.contains(searchQuery);
          }).toList();

          return Container(
            decoration: const BoxDecoration(
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
                  Expanded(
                    child: PatientWidgetView<Pationts>(
                      label1: "اسم الحالة",
                      label2: "التعديل",
                      label3: "الحذف",
                      items: filteredPatients,
                      itemNameBuilder: (item) => item.name ?? 'No Name',
                      itemEditWidgetBuilder: (item) => DialogEditPatient(
                        allPatientCubit: allPatientCubit,
                        patient: item,
                      ),
                      itemDeleteWidgetBuilder: (item) {
                        if (item == null) {
                          return const Text("Invalid Item");
                        }
                        return DialogDeletePatient(
                          allPatientCubit: allPatientCubit,
                          patient: item,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ErrorAllPatient) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
