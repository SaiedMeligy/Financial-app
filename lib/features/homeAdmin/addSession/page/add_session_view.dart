import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/core/widget/custom_text_field.dart';
import 'package:experts_app/domain/entities/AddSessionModel.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/all_advisor_drop_down.dart';
import 'package:intl/intl.dart' as intl;


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
  TextEditingController advisorComment = TextEditingController();
  String? selected_advisor;
  int? patient_id;
  int? sessionNum;
  final formKey = GlobalKey<FormState>();
  bool isMobile = false;
//todo change
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(), // Prevents selecting a date before today
  //     lastDate: DateTime(2101),
  //   );
  //   if (pickedDate != null && pickedDate != _selectedDate) {
  //     setState(() {
  //       _selectedDate = pickedDate;
  //       _updateDateTimeText();
  //     });
  //   }
  // }
  //
  //
  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //
  //   if (pickedTime != null) {
  //     final now = TimeOfDay.now();
  //     final selectedDateTime = DateTime(
  //       DateTime.now().year,
  //       DateTime.now().month,
  //       DateTime.now().day,
  //       pickedTime.hour,
  //       pickedTime.minute,
  //     );
  //     final nowDateTime = DateTime.now();
  //     final nowPlusOneHour = nowDateTime.add(const Duration(hours: 1));
  //
  //     // Validate time selection
  //     if (selectedDateTime.isAfter(nowDateTime) &&
  //         selectedDateTime.isBefore(nowPlusOneHour)) {
  //       setState(() {
  //         _selectedTime = pickedTime;
  //         _updateDateTimeText();
  //       });
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('.يرجى اختيار وقت ضمن الساعة القادمة'),
  //         ),
  //       );
  //     }
  //   }
  // }
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
      // final date = '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}';
      // final time = '${_selectedTime!.hour}:${_selectedTime!.minute}';
      DateTime newTime = DateTime(1,1,1,_selectedTime!.hour,_selectedTime!.minute,0);
      DateTime newDate = DateTime(_selectedDate!.year,_selectedDate!.month,_selectedDate!.day,0,0,0);
      String time = intl.DateFormat('HH:mm:ss').format(newTime);
      String date = intl.DateFormat('yy:MM:dd').format(newDate);

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
    return LayoutBuilder(
      builder: (context, constraints) {
        isMobile = constraints.maxWidth < 600;

      return BlocBuilder<AddSessionCubit, AddSessionStates>(
        bloc: addSessionCubit,
        builder: (context, state) {
          if (state is SuccessPatientNationalIdState) {
            if (state.result.data['pationt'] != null) {
              _namePatientController.text = state.result.data['pationt']['name'] ?? '';
              patient_id = state.result.data['pationt']['id'] ?? 0;
              _phoneNumber.text = state.result.data['pationt']['phone_number'] ?? '';
              _nameAdvisorController.text = state.result.data['pationt']["form"]?['advicor']?['name'] ?? '';
              sessionNum =state.result.data['pationt']["sessions"].length+2;
              if(sessionNum==0){
                 sessionNum=state.result.data['pationt']["sessions"].length+2;
             }
              else{
                sessionNum;
              }
            } else {
              SnackBarService.showErrorMessage( "please complete the form");
            }
          }
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/back.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.2
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color:Colors.black,
                                    width: 2,
                                  )
                              ),
                              child: Text("حجز جلسة", style: Constants.theme.textTheme
                                  .titleLarge?.copyWith(
                                  color: Colors.black,
                                  fontSize: 27
                              ),),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Text("استشارى المرحلة التانية", style: isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,fontWeight: FontWeight.bold):Constants.theme.textTheme.titleLarge?.copyWith(color: Colors.black)),
                            isMobile?SizedBox(width: 5):SizedBox(width: 15),
                            DropdownButtonAdvisor(
                              onAdvisorSelected: (advicor_id) {
                                setState(() {
                                  selected_advisor = advicor_id;
                                });
                              },
                            ),
                          ],
                        ),
                        Text("ادخل رقم الهوية الأماراتية", style: Constants.theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.black
                        )),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: _patientNationalIdController,
                                hint: "رقم الهوية الأماراتية",
                                onValidate: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "من فضلك ادخل رقم الهوية الأماراتية";
                                  }
                                  return null;
                                  },
                              ),
                            ),
                            (Constants.mediaQuery.width>600)?SizedBox(width:2):SizedBox(width: 10),
                            Container(
                              width: 50,
                              child: BorderRoundedButton(
                                title: "Get",
                                onPressed: () {
                                  addSessionCubit.getPatientDetails(_patientNationalIdController.text,0);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Container(
                              width: isMobile?Constants.mediaQuery.width*0.30:Constants.mediaQuery.width*0.09  ,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                                child: sessionNum==null?Text("الجلسة .... ",style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.black
                                ),):Text("الجلسة "+sessionNum.toString(),style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.black
                                ))).setOnlyPadding(context, 0, 0, 5, 0,enableMediaQuery: false)
                          ],
                        ),

                        SizedBox(height: 10),
                        Text("اسم استشارى المرحلة الاولى", style: Constants.theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.black
                        )),
                        SizedBox(height: 5),
                        CustomTextField(
                          controller: _nameAdvisorController,
                          hint: "اسم استشارى المرحلة الاولى",
                            onValidate: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "من فضلك ادخل اسم استشارى المرحلة الاولي";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 10),
                        Text("مدير الحالة-رقم الطلب", style: Constants.theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.black
                        )),
                        SizedBox(height: 5),
                        CustomTextField(
                          controller: _nameManagerController,
                          hint: "مدير الحالة",
                            onValidate: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "من فضلك ادخل اسم مدير الحالة";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 10),
                        Text("اسم المستفيد", style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black)),
                        SizedBox(height: 5),
                        CustomTextField(
                          controller: _namePatientController,
                          readOnly: true,
                            onValidate: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "من فضلك ادخل ادخل اسم المستفيد";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 10),
                        Text("رقم الهاتف", style: Constants.theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.black
                        )),
                        SizedBox(height: 5),
                        CustomTextField(
                          controller: _phoneNumber,
                          hint: "رقم الهاتف",
                            onValidate: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "من فضلك ادخل رقم الهاتف";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 10),
                        Text("رقم بديل الهاتف", style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black)),
                        SizedBox(height: 5),
                        CustomTextField(
                          controller: _secondPhoneNumber,
                          hint: "رقم بديل للهاتف",
                            // onValidate: (value) {
                            //   if (value == null || value.trim().isEmpty) {
                            //     return "من فضلك ادخل رقم الهاتف البديل";
                            //   }
                            //   return null;
                            // }
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () => _selectDate(context),
                              icon: Icon(Icons.date_range_outlined, size: 40, color: Colors.black),
                            ),
                            IconButton(
                              onPressed: () => _selectTime(context),
                              icon: Icon(Icons.access_time_filled_rounded, size: 40, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          controller: _dateTimeController,
                          readOnly: true,
                          hint: "اختر التاريخ والوقت",
                            onValidate: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "اختر التاريخ والوقت";
                              }
                              return null;
                            }
                        ),
                         SizedBox(height: 20,),
                         Text(
                            "ملاحظات الاستشارى",
                            style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black)
                          ),
                        SizedBox(height: 10,),
                         CustomTextField(
                            maxLines: 4,
                            hint: "ملاحظات الاستشارى",
                            controller: advisorComment,
                          ),
                        SizedBox(height: 16),
                        BorderRoundedButton(
                          title: "اضافة",

                          onPressed: () {
                            print("selected advisor: ${selected_advisor.toString()}");

                            // Check if selected_advisor is null
                            if (selected_advisor == null) {
                              SnackBarService.showErrorMessage("يرجى اختيار الأستشاري قبل إرسال الطلب");
                              return; // Exit the function early
                            }

                            if (formKey.currentState!.validate()) {
                              DateTime newTime = DateTime(1,1,1,_selectedTime!.hour,_selectedTime!.minute,0);
                              DateTime newDate = DateTime(_selectedDate!.year,_selectedDate!.month,_selectedDate!.day,0,0,0);
                              String time = intl.DateFormat('HH:mm:ss').format(newTime);
                              String date = intl.DateFormat('yy:MM:dd').format(newDate);
                              var data = Sessions(
                                date: date,
                                advicorId: int.parse(selected_advisor.toString()),
                                pationtId: patient_id ?? 0,
                                caseManager: _nameManagerController.text,
                                phoneNumber: _phoneNumber.text,
                                otherPhoneNumber: _secondPhoneNumber.text,
                                time: time,
                                comments: advisorComment.text,
                              );

                              addSessionCubit.addSession(data).then((response) {
                                if (response.data["status"] == true) {
                                  print("تم اضافة الجلسة");
                                  _dateTimeController.clear();
                                  _patientNationalIdController.clear();
                                  _namePatientController.clear();
                                  _nameAdvisorController.clear();
                                  _nameManagerController.clear();
                                  _phoneNumber.clear();
                                  _secondPhoneNumber.clear();
                                  advisorComment.clear();

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          title: Text(
                                            "تم اضافة الجلسة",
                                            style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Constants.theme.primaryColor,
                                                    width: 2.5,
                                                  ),
                                                ),
                                                child: Text(
                                                  "اغلاق",
                                                  style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ).setHorizontalPadding(
                                                  context,
                                                  enableMediaQuery: false,
                                                  20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  SnackBarService.showErrorMessage(response.data["message"]);
                                }
                              });
                            }
                          },

                        ),
                      ],
                    ).setHorizontalPadding(context, enableMediaQuery: false, 20).setVerticalPadding(context, enableMediaQuery: false, 20),
                  ),
                ),
              ),
            ),
          );
        },
      );}
    );
  }
}
// https://SaiedMeligy.github.io/FinancilaClinic/