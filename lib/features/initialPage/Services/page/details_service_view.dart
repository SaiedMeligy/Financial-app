import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/domain/entities/AllSessionModel.dart';
import 'package:experts_app/features/homeAdmin/bookingSession/page/booking_session_view.dart';
import 'package:experts_app/features/initialPage/Services/page/booking_Service_View.dart';
import 'package:experts_app/features/initialPage/Services/page/login_with_patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/constants.dart';

class DetailsServiceView extends StatefulWidget {
  final String consultationName;
  final String consultationDescription;
   const DetailsServiceView({super.key,required this.consultationName,required this.consultationDescription});

  @override
  State<DetailsServiceView> createState() => _DetailsServiceViewState();
}

class _DetailsServiceViewState extends State<DetailsServiceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.theme.primaryColor,
        toolbarHeight: Constants.mediaQuery.height * 0.24,
        leadingWidth: Constants.mediaQuery.width * 0.3,
        leading:
        Row(
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
                      ),child: Text("تفاصيل الخدمة",style: Constants.theme.textTheme.bodyLarge?.copyWith(fontSize: 28,color: Colors.black),)),
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
                          Text("وصف الخدمة الاستشارية : ${widget.consultationDescription }",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,fontSize: 24),),
                        ],
                      ),
                    ).setHorizontalPadding(context,enableMediaQuery: false, 20),
                    SizedBox( height:100),
                    BorderRoundedButton(title: "ابدأ الخدمة",onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                       return BookingServiceView(consultationName: widget.consultationName, consultationDescription: widget.consultationDescription);

                         //LoginWithPatient();
                      },));
                    },).setHorizontalPadding(context,enableMediaQuery: false, 20),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
