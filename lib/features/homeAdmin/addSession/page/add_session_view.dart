import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/core/widget/custom_text_field.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';
import 'package:flutter/material.dart';

import '../widget/all_advisor_drop_down.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddSessionView extends StatefulWidget {
  @override
  _AddSessionViewState createState() => _AddSessionViewState();
}

class _AddSessionViewState extends State<AddSessionView> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TextEditingController _dateTimeController = TextEditingController();
  TextEditingController _patientNationalIdController = TextEditingController();
  TextEditingController _namePatientController = TextEditingController();
  TextEditingController _nameAdvisorController = TextEditingController();
  TextEditingController _nameManagerController = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _secondPhoneNumber = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
        _updateDateTimeText();
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _selectedTime)
      setState(() {
        _selectedTime = pickedTime;
        _updateDateTimeText();
      });
  }

  void _updateDateTimeText() {
    if (_selectedDate != null && _selectedTime != null) {
      final date = '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
      final time = '${_selectedTime!.hour}:${_selectedTime!.minute}';
      _dateTimeController.text = '$date $time';
    }
  }

  var addSessionCubit = AddSessionCubit();

  @override
  void dispose() {
    _dateTimeController.dispose();
    _patientNationalIdController.dispose();
    _namePatientController.dispose();
    _nameAdvisorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddSessionCubit,AddSessionStates>(
      bloc: addSessionCubit,
      builder: (context, state) {
        if (state is SuccessPatientNationalIdState) {
          _namePatientController.text = state.result.data['pationt']['name'];
          _phoneNumber.text = state.result.data['pationt']['phone_number'];
          _nameAdvisorController.text = state.result.data["pationt"]["form"]['advicor']['name'];
        }
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text("حجز جلسة",style: Constants.theme.textTheme.titleLarge,),
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.black87,
            ),
            body: Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                  opacity: 1.0,
                ),
              ),
              child: SingleChildScrollView(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text("استشاري المرحلة التانية", style: Constants.theme.textTheme.titleLarge),
                        SizedBox(width: 15),
                        DropdownButtonAdvisor(),
                      ],
                    ),
                    Text("ادخل الرقم القومي", style: Constants.theme.textTheme.bodyLarge),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _patientNationalIdController,
                          ),
                        ),
                        SizedBox(width: 10,),
                        BorderRoundedButton(
                            title: "Get",
                            onPressed: () {
                              addSessionCubit.getPatientDetails(
                                  _patientNationalIdController.text);
                            }
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("اسم استشاري المرحلة الاولي", style: Constants.theme.textTheme.bodyLarge),
                    SizedBox(height: 5,),
                    CustomTextField(
                      controller: _nameAdvisorController,
                      hint: "اسم استشاري المرحلة الاولي",

                    ),
                    SizedBox(height: 10,),
                    Text("مدير الحالة", style: Constants.theme.textTheme.bodyLarge),
                    SizedBox(height: 5,),
                    CustomTextField(
                      controller: _nameManagerController,
                      hint: "مدير الحالة",
                    ),
                    SizedBox(height: 10,),
                    Text("اسم المستفيد", style: Constants.theme.textTheme.bodyLarge),
                    SizedBox(height: 5,),
                    CustomTextField(
                      controller: _namePatientController,
                      readOnly: true,
                    ),
                    SizedBox(height: 10,),
                    Text("رقم الهاتف", style: Constants.theme.textTheme.bodyLarge),
                    SizedBox(height: 5,),
                    CustomTextField(
                      controller: _phoneNumber,
                      hint: "رقم الهاتف",
                      readOnly: true,
                    ),
                    SizedBox(height: 10,),
                    Text("رقم بديل الهاتف", style: Constants.theme.textTheme.bodyLarge),
                    SizedBox(height: 5,),
                    CustomTextField(
                      controller: _secondPhoneNumber,
                      hint: "رقم بديل للهاتف",
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () => _selectDate(context),
                          icon: Icon(Icons.date_range_outlined, size: 40,
                              color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () => _selectTime(context),
                          icon: Icon(Icons.access_time_filled_rounded, size: 40,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      controller: _dateTimeController,
                      readOnly: true,
                      hint: "اختر التاريخ والوقت",
                    ),
                    SizedBox(height: 16),
                    BorderRoundedButton(title: "اضافة"),
                  ],
                ).setHorizontalPadding(context,enableMediaQuery: false,20).setVerticalPadding(context,enableMediaQuery: false, 20),
              ),
            ),
          ),
        );
      }
    );
      }
}
