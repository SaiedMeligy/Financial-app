

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/constants.dart';
import '../../../../../domain/entities/ConsultationViewModel.dart';
import '../../../Consulting service/All Consultation/manager/cubit.dart';
import '../../../Consulting service/All Consultation/manager/states.dart';

class DropDownWithAdmin extends StatefulWidget {
  final ValueChanged<int> onChange;
  DropDownWithAdmin({super.key, required this.onChange});

  @override
  State<DropDownWithAdmin> createState() => _DropDownWithAdminState(onChange: onChange);
}

class _DropDownWithAdminState extends State<DropDownWithAdmin> {
  var allConsultationCubit = AllConsultationCubit();
  ConsultationServices? selectedValue;
  final ValueChanged<int> onChange;

  _DropDownWithAdminState({required this.onChange});

  @override
  void initState() {
    super.initState();
    allConsultationCubit.getAllConsultationsAdmin();
  }

  void handleDropdownValueChanged(ConsultationServices? newValue) {
    setState(() {
      selectedValue = newValue;
      if (newValue != null) {
        onChange(newValue.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllConsultationCubit, AllConsultationStates>(
      bloc: allConsultationCubit,
      builder: (context, state) {
        if (state is LoadingAllConsultations) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessAllConsultations) {
          var consultations = state.consultationServices;

          if (selectedValue == null && consultations.isNotEmpty) {
            selectedValue = consultations.first;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              handleDropdownValueChanged(selectedValue);
            });
          }

          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: DropdownButton<ConsultationServices>(
              value: selectedValue,
              onChanged: handleDropdownValueChanged,
              items: consultations.map((dynamic value) {
                return DropdownMenuItem<ConsultationServices>(
                  value: value,
                  child: Text(
                    value.name,
                    style: Constants.theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
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