import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/features/initialPage/Services/manager/cubit.dart';
import 'package:experts_app/features/initialPage/Services/manager/states.dart';
import 'package:experts_app/features/initialPage/Services/page/login_with_patient.dart';
import 'package:experts_app/features/initialPage/Services/page/services_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../domain/entities/ConsultationViewModel.dart';

class BookingServiceView extends StatefulWidget {
  // final String consultationName;
  // final String consultationDescription;
  final ConsultationServices consultation;
  const BookingServiceView({super.key,required this.consultation});

  @override
  State<BookingServiceView> createState() => _BookingServiceViewState();
}

class _BookingServiceViewState extends State<BookingServiceView> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TextEditingController _dateTimeController = TextEditingController();
  String? _selectedAttendanceType;
  int? _selectedAttendanceValue;

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
  var reserveServiceCubit = AddServiceCubit();
  late int patientId  = CacheHelper.getData(key: 'id') ;

  void _updateDateTimeText() {
    if (_selectedDate != null && _selectedTime != null) {
      final date = '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}';
      final time = '${_selectedTime!.hour}:${_selectedTime!.minute}';
      _dateTimeController.text = '$date $time';
    }
  }
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (CacheHelper.getData(key: 'id') != null) {
        patientId = CacheHelper.getData(key: 'id');
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPatient()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.theme.primaryColor,
        toolbarHeight: (Constants.mediaQuery.width < 600)
            ? Constants.mediaQuery.height * 0.17
            : Constants.mediaQuery.height * 0.24,
        leadingWidth: (Constants.mediaQuery.width < 600)
            ? Constants.mediaQuery.height * 0.21
            : Constants.mediaQuery.width * 0.35,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServicesView(),
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_back,
                size: (Constants.mediaQuery.width < 600) ? 10 : 40,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/AEI Logo.png"),
                    fit: (Constants.mediaQuery.width < 600) ? BoxFit.fitWidth : BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 10),
        title: Column(
          children: [
            Text(
              (Constants.mediaQuery.width < 600) ? "العيادة \nالمالية" : "العيادة المالية",
              style: (Constants.mediaQuery.width < 600)
                  ? Constants.theme.textTheme.bodyMedium
                  : Constants.theme.textTheme.titleLarge,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Container(
            height: (Constants.mediaQuery.width < 600)
                ? Constants.mediaQuery.height * 0.10
                : Constants.mediaQuery.height * 0.6,
            width: (Constants.mediaQuery.width < 600)
                ? Constants.mediaQuery.height * 0.12
                : Constants.mediaQuery.width * 0.29,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage("assets/images/لوجو الهيئة.png"),
                fit: (Constants.mediaQuery.width < 600) ? BoxFit.fitWidth : BoxFit.cover,
              ),
            ),
          ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 10),
        ],
      ),
      body: BlocBuilder<AddServiceCubit,AddServiceStates>(
        bloc: reserveServiceCubit,
        builder:(context, state) {
          return ListView(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/back.jpg'),
                          fit: BoxFit.cover,
                          opacity: 0.2
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              // margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black, width: 2)
                              ), child: Text("حجز الخدمة", style: Constants.theme
                              .textTheme.bodyLarge?.copyWith(
                              fontSize: 28, color: Colors.black),)),
                        ],
                      ),
                      SizedBox(height: 20,),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Constants.theme.primaryColor.withOpacity(
                                      0.3),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black, width: 2)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("الخدمة الاستشارية : ${widget.consultation
                                      .name}",
                                    style: Constants.theme.textTheme.bodyLarge
                                        ?.copyWith(
                                        color: Colors.black, fontSize: 25),),
                                  Text(
                                    "وصف الخدمة الاستشارية : ${widget.consultation
                                        .description} ",
                                    style: Constants.theme.textTheme.bodyMedium
                                        ?.copyWith(
                                        color: Colors.black, fontSize: 24),),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () => _selectDate(context),
                                  icon: const Icon(Icons.date_range_outlined, size: 40,
                                      color: Colors.black),
                                ),
                                IconButton(
                                  onPressed: () => _selectTime(context),
                                  icon: const Icon(
                                      Icons.access_time_filled_rounded, size: 40,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                                controller: _dateTimeController,
                                readOnly: true,
                                hint: "اختر التاريخ والوقت",
                                onValidate: (value) {
                                  if (value == null || value
                                      .trim()
                                      .isEmpty) {
                                    return "اختر التاريخ والوقت";
                                  }
                                  return null;
                                }
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'اختر نوع الحضور:',
                                      style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                                    ),
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: 'حضوري',
                                          groupValue: _selectedAttendanceType,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _selectedAttendanceType = value;
                                              _selectedAttendanceValue = 0;
                                              print("-----------"+_selectedAttendanceValue.toString());
                                            });
                                          },
                                        ),
                                        Text('حضوري',style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: 'بالهاتف',
                                          groupValue: _selectedAttendanceType,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _selectedAttendanceType = value;
                                              _selectedAttendanceValue = 1;
                                              print("-----------"+_selectedAttendanceValue.toString());

                                            });
                                          },
                                        ),
                                        Text('بالهاتف',style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: 'اونلاين',
                                          groupValue: _selectedAttendanceType,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _selectedAttendanceType = value;
                                              _selectedAttendanceValue = 2;
                                              print("-----------"+_selectedAttendanceValue.toString());

                                            });
                                          },
                                        ),
                                        Text('اونلاين',style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            BorderRoundedButton(title: "حجز الخدمة",onPressed: (){
                              reserveServiceCubit.reserveService(
                                widget.consultation.id,
                                patientId,
                                "${_selectedTime?.hour}:${_selectedTime?.minute}",
                                  _selectedDate?.toString() ?? '',
                                _selectedAttendanceValue!,
                              ).then((value) {
                                SnackBarService.showSuccessMessage("تم حجز الخدمة");
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => ServicesView()),
                                      (Route<dynamic> route) => false, // This removes all previous routes
                                );
                              });
                            },)
                          ],
                        ),
                      ).setHorizontalPadding(context, enableMediaQuery: false, 20),

                    ],
                  ).setHorizontalPadding(context,enableMediaQuery: false, 20).setVerticalPadding(context,enableMediaQuery: false,20)
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
