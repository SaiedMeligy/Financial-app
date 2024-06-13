import 'package:experts_app/core/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:experts_app/domain/entities/AllAdvisorsModel.dart';
import 'package:experts_app/features/homeAdmin/addSession/widget/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/widget/manager/states.dart';

class DropdownButtonAdvisor extends StatefulWidget {
  @override
  _DropdownButtonAdvisorState createState() => _DropdownButtonAdvisorState();
}

class _DropdownButtonAdvisorState extends State<DropdownButtonAdvisor> {
  String? selectedValue;
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
          return CircularProgressIndicator();
        } else if (state is SuccessAllAdvisorState) {
          var advisors = state.advisors;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 1,
              )
            ),
            child: DropdownButton<String>(
              value: selectedValue,
              hint: Text('اختر الاستشاري',
                style: Constants.theme.textTheme.bodyLarge,
              ),
              icon: Icon(Icons.arrow_downward,color: Colors.black87,),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.black),
              // underline: Container(
              //   height: 2,
              //   color: Colors.black,
              // ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue;
                });
              },
              items: advisors.map<DropdownMenuItem<String>>((advisor) {
                return DropdownMenuItem<String>(
                  value: advisor.name,
                  child: Text(advisor.name.toString(),textAlign:TextAlign.center,style: Constants.theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.black87,
                  ),),
                );
              }).toList(),
            ),
          );
        } else if (state is ErrorAllAdvisorState) {
          return Text(state.errorMessage);
        } else {
          return Text('Error');
        }
      },
    );
  }
}
