import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/Consulting%20service/All%20Consultation/manager/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/ConsultationViewModel.dart';
import '../../../homeAdmin/Consulting service/All Consultation/manager/states.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  var allConsultationCubit = AllConsultationCubit();
  String? selectedValue; // Added to store the selected value

  @override
  void initState() {
    super.initState();
    allConsultationCubit.getAllConsultations(); // Fetch consultations on init
  }

  void handleDropdownValueChanged(String? newValue) {
    setState(() {
      selectedValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllConsultationCubit, AllConsultationStates>(
      bloc: allConsultationCubit,
      builder: (context, state) {
        if (state is LoadingAllConsultations) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (state is SuccessAllConsultations) {
          var consultations = state.consultationServices;
          var consultationNames = consultations.map((c) => c.name).toList();
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              )
            ),
            child: DropdownButton<String>(
              value: selectedValue,
              onChanged: handleDropdownValueChanged,
              items: consultationNames.map((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style: Constants.theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black
                  ),),
                );
              }).toList(),
            ),
          );
        } else if (state is ErrorAllConsultations) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
