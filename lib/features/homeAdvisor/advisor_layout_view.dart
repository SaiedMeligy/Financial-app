


import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/domain/entities/QuestionView.dart';
import 'package:experts_app/features/homeAdvisor/add_user/page/add_user_view.dart';
import 'package:experts_app/features/homeAdvisor/home/page/home_advisor_view.dart';
import 'package:experts_app/features/homeAdvisor/session%20dates/page/session_data_view.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/page/patient_nationalId.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/page/view_question.dart';
import 'package:flutter/material.dart';

import '../../core/config/constants.dart';
import '../../domain/entities/side_bar_model.dart';
import '../homeAdmin/logout/page/logout_view.dart';
import 'cases/page/cases_view.dart';

class AdvisorLayoutView extends StatefulWidget {
  const AdvisorLayoutView({super.key});

  @override
  State<AdvisorLayoutView> createState() => _AdvisorLayoutViewState();
}

class _AdvisorLayoutViewState extends State<AdvisorLayoutView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<SideBarModel> titles = [
      SideBarModel(title: "الصفحة الرئيسية", icon: Icon(Icons.home)),
      SideBarModel(title: "حالاتك", icon: Icon(Icons.list)),
      SideBarModel(title: "بدء جلسة", icon: Icon(Icons.timer)),
      SideBarModel(title: "مواعيد الجلسات", icon: Icon(Icons.access_time_rounded)),
      SideBarModel(title: "اضافة جلسة", icon: Icon(Icons.add)),
      SideBarModel(title: "حجز المواعيد", icon: Icon(Icons.list)),
      SideBarModel(title: "اضافة حالة", icon: Icon(Icons.add)),
    ];
    List<Widget> bodies = [
      HomeAdvisorView(),
      CasesView(),
      PatientNationalId(),
      // ViewQuestion(),
      // Center(child: Text("بدء جلسة",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black))),
      SessionDate(),
      Center(child: Text("تعديل المؤاشرات",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black))),
      Center(child: Text("تعديل المؤاشرات",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black))),
      AddUserView(),
      // Center(child: Text("اضافة حالة",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black))),
    ];

    return Scaffold(
      //backgroundColor: Colors.black87,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
        toolbarHeight: Constants.mediaQuery.height * 0.22,
        leadingWidth: Constants.mediaQuery.width * 0.25,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/logo2.png",
                  ),
                  fit: BoxFit.cover,)),
        )
            .setVerticalPadding(context, enableMediaQuery: false, 10)
            .setHorizontalPadding(context, enableMediaQuery: false, 10),
        title: Text(
          "العيادات المالية",
          style: Constants.theme.textTheme.titleLarge,
        ),
        actions: [
         LogoutView(),
        ],
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Container(
              width: Constants.mediaQuery.width * 0.24,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            child: Container(
                              color:
                                  currentIndex == index ? Colors.grey : Colors.black,
                              child: ListTile(
                                title:
                                Row(
                                  children: [
                                    titles[index].icon,
                                    const SizedBox(
                                      width: 10,
                                    ),

                                    Text(
                                      titles[index].title,
                                      style: currentIndex == index
                                          ? Constants.theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                  color: Constants.theme.primaryColor)
                                          : Constants.theme.textTheme.bodyMedium,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                titleTextStyle: Constants.theme.textTheme.bodyMedium,
                                contentPadding: currentIndex == index
                                    ? EdgeInsets.zero
                                    : const EdgeInsets.symmetric(horizontal: 2),
                                dense: true,
                                style: ListTileStyle.list,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: titles.length,
                  ),
                ),
              ]).setVerticalPadding(enableMediaQuery: false, context, 20),
            ),
            Expanded(child: Container(
              color: Colors.white10,
                child: Container(
                    child: bodies[currentIndex])),),
          ],
        ),
      ),
    );
  }
}
