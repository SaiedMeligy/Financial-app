
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/domain/entities/side_bar_model.dart';
import 'package:experts_app/features/homeAdmin/allQuestionView/page/all_question_view.dart';
import 'package:experts_app/features/homeAdmin/bookingSession/page/booking_session_view.dart';
import 'package:experts_app/features/homeAdmin/pointerReport/page/pointer_report_view.dart';
import 'package:experts_app/features/homeAdmin/pointers/page/addPointer/add_indicator.dart';
import 'package:experts_app/features/homeAdmin/pointers/page/all%20Pointers/page/edit_indicator.dart';
import 'package:experts_app/features/homeAdmin/registrationAdvisor/page/register_view.dart';
import 'package:experts_app/features/homeAdmin/staticScreen/page/static_screen.dart';
import 'package:experts_app/features/homeAdvisor/recycle_pin/page/all_patient_recycle_admin_view.dart';
import 'package:flutter/material.dart';

import '../../core/config/cash_helper.dart';
import '../../core/config/constants.dart';
import 'Advices/page/All Advices/page/advice_view.dart';
import 'Advices/page/addAdvice/add_advice.dart';
import 'Consulting service/All Consultation/page/consulting_view.dart';
import 'Consulting service/Consultation Store/page/add_consulting.dart';
import 'addSession/page/add_session_view.dart';
import 'add_patient/page/add_patient_view.dart';
import 'adviceReport/page/advice_report_view.dart';
import 'allPatientsAdmin/page/all_patient_admin_view.dart';
import 'logout/page/logout_view.dart';
import 'question/pages/add_question.dart';

class HomeAdminView extends StatefulWidget {
  const HomeAdminView({super.key});

  @override
  State<HomeAdminView> createState() => _HomeAdminViewState();
}

class _HomeAdminViewState extends State<HomeAdminView> {
  int currentIndex = 0;
  bool isMobile = false;
  late String admin_name;

  @override
  void initState() {
    super.initState();
    admin_name = CacheHelper.getData(key: 'name');

  }
  Widget build(BuildContext context) {
    List<SideBarModel> titles = [
      SideBarModel(title: "الصفحة الرئيسية", icon: Icon(Icons.home,color: Colors.black87,)),
      SideBarModel(title: "اضافة حالة", icon: Icon(Icons.add,color: Colors.black87)),
      SideBarModel(title: "الحالات", icon: Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "المحذوفات", icon: Icon(Icons.delete,color: Colors.black87)),
      SideBarModel(title: "تقارير المؤشرات", icon: Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "تقارير التوصيات", icon: Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "اضافة الأسئلة", icon: Icon(Icons.add,color: Colors.black87)),
      SideBarModel(title: "عرض الأسئلة", icon: Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "اضافة المؤشرات", icon: Icon(Icons.add,color: Colors.black87)),
      SideBarModel(title: "المؤشرات", icon: Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "اضافة التوصيات", icon: Icon(Icons.add,color: Colors.black87)),
      SideBarModel(title: " التوصيات", icon: Icon(Icons.list,color: Colors.black87)),
      // SideBarModel(title: "اضافة الحالات من مصدر خارجي", icon: Icon(Icons.add,color: Colors.black87)),
      SideBarModel(title: "حجز جلسات", icon: Icon(Icons.border_color_outlined,color: Colors.black87)),
      SideBarModel(title: "الجلسات المحجوزة", icon: Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "اضافة خدمة استشارية", icon: Icon(Icons.add,color: Colors.black87)),
      SideBarModel(title: "الخدمات الاستشارية", icon: Icon(Icons.list,color: Colors.black87)),
      SideBarModel(title: "اضافة استشاري", icon: Icon(Icons.add,color: Colors.black87)),
    ];

    List<Widget> bodies = [
      StaticScreen(),
      AddPatientView(),
      AllPatientAdminView(),
      AllPatientRecycleAdminView(),
      PointerReportView(),
      AdviceReportView(),
      AddQuestion(),
      AllQuestionView(),
      AddIndicator(),
      EditIndicator(),
      AddRecommend(),
      EditAdviceView(),
      // Center(child: Text("اضافة الحالات من مصدر خارجي",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black))),
      AddSessionView(),
      BookingSessionView(),
      AddConsulting(),
      ConsultingView(),
      RegisterView(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        isMobile = constraints.maxWidth < 600;

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
                Text(
                  "$admin_name",
                  style: Constants.theme.textTheme.titleLarge,
                ),
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
              LogoutView()
            ],
          ),
          drawer: isMobile
              ? Drawer(
            backgroundColor: Constants.theme.primaryColor,
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Constants.theme.primaryColor,
                  ),

                  child: Container(

                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/logo2.png",),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ...titles.map((title) {
                  int index = titles.indexOf(title);
                  return ListTile(
                    title: Row(
                      children: [
                        titles[index].icon,
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            titles[index].title,
                            style: Constants.theme.textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                        Navigator.pop(context);
                      });
                    },
                  );
                }).toList(),
              ],
            ),
          )
              : null,
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                if (!isMobile)
                  Container(
                    width: Constants.mediaQuery.width * 0.24,
                    decoration: BoxDecoration(
                      color: Constants.theme.primaryColor,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: titles.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                child: Container(
                                  color: currentIndex == index ? Colors.black54 : Constants.theme.primaryColor.withOpacity(0.5),
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        titles[index].icon,
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            titles[index].title,
                                            style: currentIndex == index
                                                ? Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.white, fontSize: 24)
                                                : Constants.theme.textTheme.bodyLarge?.copyWith(fontSize: 20,color: Colors.black),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                    dense: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ).setVerticalPadding(enableMediaQuery: false, context, 20),
                  ),
                Expanded(
                  child: Container(
                    color: Constants.theme.primaryColor.withOpacity(0.3),
                    child: bodies[currentIndex],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

