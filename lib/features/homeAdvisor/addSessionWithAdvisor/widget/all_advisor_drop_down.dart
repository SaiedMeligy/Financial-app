import 'package:experts_app/core/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:experts_app/features/homeAdmin/addSession/widget/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/widget/manager/states.dart';

class DropdownButtonAdvisor extends StatefulWidget {
  final Function(String) onAdvisorSelected;

  const DropdownButtonAdvisor({required this.onAdvisorSelected});

  @override
  _DropdownButtonAdvisorState createState() => _DropdownButtonAdvisorState();
}

class _DropdownButtonAdvisorState extends State<DropdownButtonAdvisor> {
  String? selectedValue;
  String? selectedAdvisorId;
  late AllAdvisorCubit allAdvisorsCubit;

  @override
  void initState() {
    super.initState();
    allAdvisorsCubit = AllAdvisorCubit();
    allAdvisorsCubit.getAllAdvisor();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllAdvisorCubit, AllAdvisorState>(
      bloc: allAdvisorsCubit,
      builder: (context, state) {
        if (state is LoadingAllAdvisorState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SuccessAllAdvisorState) {
          var advisors = state.advisors;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: Constants.theme.primaryColor.withOpacity(0.8),
                value: selectedValue,
                hint: Text(
                  'اختر الاستشاري',
                  style: Constants.theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                  ),
                ),
                icon: Icon(Icons.arrow_downward, color: Colors.black87),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                    selectedAdvisorId = newValue;
                  });
                  widget.onAdvisorSelected(selectedAdvisorId!);
                },
                items: advisors.map<DropdownMenuItem<String>>((advisor) {
                  return DropdownMenuItem<String>(
                    value: advisor.id.toString(),
                    child: Text(
                      advisor.name.toString(),
                      textAlign: TextAlign.center,
                      style: Constants.theme.textTheme.bodyLarge,
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        } else if (state is ErrorAllAdvisorState) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Center(child: Text('Error loading advisors'));
        }
      },
    );
  }
}
