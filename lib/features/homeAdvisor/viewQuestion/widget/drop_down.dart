import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/Consulting%20service/All%20Consultation/manager/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/ConsultationViewModel.dart';
import '../../../homeAdmin/Consulting service/All Consultation/manager/states.dart';

class DropDown extends StatefulWidget {
  final ValueChanged<int> onChange;
  var items;
  DropDown({super.key, required this.onChange,  this.items});

  @override
  State<DropDown> createState() => _DropDownState(onChange: onChange);
}

class _DropDownState extends State<DropDown> {
  var allConsultationCubit = AllConsultationCubit();
  ConsultationServices? selectedValue;
  final ValueChanged<int> onChange;
  bool isMobile = false;

  _DropDownState({required this.onChange});

  @override
  void initState() {
    super.initState();
    allConsultationCubit.getAllConsultations();
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
    return LayoutBuilder(
      builder: (context, constraints) {

      isMobile = constraints.maxWidth < 600;

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
                      style: isMobile?Constants.theme.textTheme.bodySmall?.copyWith(color: Colors.black,):Constants.theme.textTheme.bodyMedium?.copyWith(
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
      );}
    );
  }
}