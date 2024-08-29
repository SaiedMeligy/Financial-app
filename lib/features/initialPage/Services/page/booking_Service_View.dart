import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/widget/custom_text_field.dart';

class BookingServiceView extends StatefulWidget {
  final String consultationName;
  final String consultationDescription;
  const BookingServiceView({super.key,required this.consultationName,required this.consultationDescription});

  @override
  State<BookingServiceView> createState() => _BookingServiceViewState();
}

class _BookingServiceViewState extends State<BookingServiceView> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TextEditingController _dateTimeController = TextEditingController();
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
      final date = '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}';
      final time = '${_selectedTime!.hour}:${_selectedTime!.minute}';
      _dateTimeController.text = '$date $time';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.theme.primaryColor,
        toolbarHeight: Constants.mediaQuery.height * 0.24,
        leadingWidth: Constants.mediaQuery.width * 0.3,
        leading: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back)),
            Expanded(
              child: Container(
                height: Constants.mediaQuery.height*0.65,
                width: Constants.mediaQuery.width*0.4,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo2.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 10),
        title: Column(
          children: [
            Text(
              "العيادة المالية",
              style: Constants.theme.textTheme.titleLarge,
            ),
            SizedBox(height: 15,),
          ],
        ),
        centerTitle: true,
        actions: [
          Container(
            height: Constants.mediaQuery.height*0.6,
            width: Constants.mediaQuery.width*0.27,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage("assets/images/لوجو الهيئة.png"),
                fit: BoxFit.cover,
              ),
            ),
          ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 10),

        ],
      ),
      body: Directionality(
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
                      margin: EdgeInsets.all(10),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black,width: 2)
                      ),child: Text("حجز الخدمة",style: Constants.theme.textTheme.bodyLarge?.copyWith(fontSize: 28,color: Colors.black),)),
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
                          color: Constants.theme.primaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black,width: 2)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("الخدمة الاستشارية : ${widget.consultationName}",style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black,fontSize: 25),),
                          Text("وصف الخدمة الاستشارية : ${widget.consultationDescription} ",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,fontSize: 24),),
                        ],
                      ),
                    ),
                    SizedBox( height:50),
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
                    SizedBox(height: 50,),
                    BorderRoundedButton(title: "حجز الخدمة")
                  ],
                ),
              ).setHorizontalPadding(context,enableMediaQuery: false, 20),

            ],
          ),
        ),
      ),
    );
  }
}
