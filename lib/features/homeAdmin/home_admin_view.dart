
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/domain/entities/side_bar_model.dart';
import 'package:experts_app/features/homeAdmin/allQuestionView/page/all_question_view.dart';
import 'package:experts_app/features/homeAdmin/bookingSession/page/booking_session_view.dart';
import 'package:experts_app/features/homeAdmin/pointerReport/page/pointer_report_view.dart';
import 'package:experts_app/features/homeAdmin/pointers/page/addPointer/add_indicator.dart';
import 'package:experts_app/features/homeAdmin/pointers/page/all%20Pointers/page/edit_indicator.dart';
import 'package:experts_app/features/homeAdmin/registrationAdvisor/page/register_view.dart';
import 'package:experts_app/features/homeAdmin/staticScreen/page/static_screen.dart';
import 'package:flutter/material.dart';

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

// class HomeAdminView extends StatefulWidget {
//   const HomeAdminView({super.key});
//
//   @override
//   State<HomeAdminView> createState() => _HomeAdminViewState();
// }
//
// class _HomeAdminViewState extends State<HomeAdminView> {
//   int currentIndex = 0;
//   bool isMobile = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     List<SideBarModel> titles = [
//       SideBarModel(title: "الصفحة الرئيسية", icon: Icon(Icons.home)),
//       SideBarModel(title: "اضافة حالة", icon: Icon(Icons.add)),
//       SideBarModel(title: "الحالات", icon: Icon(Icons.list)),
//       SideBarModel(title: "تقارير المؤاشرات", icon: Icon(Icons.list)),
//       SideBarModel(title: "تقارير التوصيات", icon: Icon(Icons.list)),
//       SideBarModel(title: "اضافة الأسئلة", icon: Icon(Icons.add)),
//       SideBarModel(title: "عرض الأسئلة", icon: Icon(Icons.list)),
//       SideBarModel(title: "اضافة المؤاشرات", icon: Icon(Icons.add)),
//       SideBarModel(title: "المؤاشرات", icon: Icon(Icons.list)),
//       SideBarModel(title: "اضافة التوصيات", icon: Icon(Icons.add)),
//       SideBarModel(title: " التوصيات", icon: Icon(Icons.list)),
//       SideBarModel(title: "اضافة الحالات من مصدر خارجي", icon: Icon(Icons.add)),
//       SideBarModel(title: "حجز جلسات", icon: Icon(Icons.border_color_outlined)),
//       SideBarModel(title: "الجلسات المحجوزة", icon: Icon(Icons.list)),
//       SideBarModel(title: "اضافة خدمة استشارية", icon: Icon(Icons.add)),
//       SideBarModel(title: "الخدمات الاستشارية", icon: Icon(Icons.list)),
//       SideBarModel(title: "اضافة استشاري", icon: Icon(Icons.add)),
//
//     ];
//     List<Widget> bodies = [
//       StaticScreen(),
//       AddPatientView(),
//       AllPatientAdminView(),
//       PointerReportView(),
//       AdviceReportView(),
//       AddQuestion(),
//       AllQuestionView(),
//       AddIndicator(),
//       EditIndicator(),
//       AddRecommend(),
//       EditAdviceView(),
//       Center(child: Text("اضافة الحالات من مصدر خارجي",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black))),
//       AddSessionView(),
//       BookingSessionView(),
//       AddConsulting(),
//       ConsultingView(),
//       RegisterView(),
//     ];
//
//     return isMobile?Drawer(
//
//     ):
//     Scaffold(
//       //backgroundColor: Colors.black87,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Constants.theme.primaryColor,
//         toolbarHeight: Constants.mediaQuery.height * 0.22,
//         leadingWidth: Constants.mediaQuery.width * 0.25,
//         leading: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: const BoxDecoration(
//               //borderRadius: BorderRadius.all(Radius.circular(10)),
//               image: DecorationImage(
//                   image: AssetImage(
//                     "assets/images/logo2.png",
//                   ),
//                   fit: BoxFit.cover,)),
//         )
//             .setVerticalPadding(context, enableMediaQuery: false, 10)
//             .setHorizontalPadding(context, enableMediaQuery: false, 10),
//         title: Text(
//           "العيادات المالية",
//           style: Constants.theme.textTheme.titleLarge,
//         ),
//         actions: [
//           LogoutView(),
//
//         ],
//         centerTitle: true,
//       ),
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Row(
//           children: [
//             Container(
//               //height: Constants.mediaQuery.height*0.7,
//               width: Constants.mediaQuery.width * 0.24,
//               decoration:  BoxDecoration(
//                 color: Colors.black.withOpacity(0.86),
//               ),
//               child: Column(children: [
//                 Expanded(
//                   child: Container(
//                     height: Constants.mediaQuery.height*0.7,
//                     child: ListView.builder(
//                       itemBuilder: (context, index) {
//                         return Column(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   currentIndex = index;
//                                 });
//                               },
//                               child: Container(
//                                 color: currentIndex == index ? Colors.grey : Constants.theme.primaryColor.withOpacity(0.3),
//                                 child: ListTile(
//                                   title: Row(
//                                     children: [
//                                       titles[index].icon,
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//
//                                       Expanded(
//                                         child: Text(
//                                           titles[index].title,
//                                           style: currentIndex == index
//                                               ? Constants.theme.textTheme.bodyLarge
//                                                   ?.copyWith(
//                                                       color: Constants.theme.primaryColor,
//                                             fontSize: 21
//                                           )
//                                               : Constants.theme.textTheme.bodyMedium,
//                                           textAlign: TextAlign.start,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   titleTextStyle: Constants.theme.textTheme.bodyMedium,
//                                   contentPadding: currentIndex == index
//                                       ? EdgeInsets.zero
//                                       : const EdgeInsets.symmetric(horizontal: 2),
//                                   dense: true,
//                                   style: ListTileStyle.list,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                       itemCount: titles.length,
//                     ),
//                   ),
//                 ),
//               ]).setVerticalPadding(enableMediaQuery: false, context, 20),
//             ),
//             Expanded(child: Container(
//               color: Constants.theme.primaryColor.withOpacity(0.3),
//                 child: Container(
//                     child: bodies[currentIndex])),),
//           ],
//         ),
//       ),
//     );
//   }
// }
class HomeAdminView extends StatefulWidget {
  const HomeAdminView({super.key});

  @override
  State<HomeAdminView> createState() => _HomeAdminViewState();
}

class _HomeAdminViewState extends State<HomeAdminView> {
  int currentIndex = 0;
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    List<SideBarModel> titles = [
      SideBarModel(title: "الصفحة الرئيسية", icon: Icon(Icons.home)),
      SideBarModel(title: "اضافة حالة", icon: Icon(Icons.add)),
      SideBarModel(title: "الحالات", icon: Icon(Icons.list)),
      SideBarModel(title: "تقارير المؤاشرات", icon: Icon(Icons.list)),
      SideBarModel(title: "تقارير التوصيات", icon: Icon(Icons.list)),
      SideBarModel(title: "اضافة الأسئلة", icon: Icon(Icons.add)),
      SideBarModel(title: "عرض الأسئلة", icon: Icon(Icons.list)),
      SideBarModel(title: "اضافة المؤاشرات", icon: Icon(Icons.add)),
      SideBarModel(title: "المؤاشرات", icon: Icon(Icons.list)),
      SideBarModel(title: "اضافة التوصيات", icon: Icon(Icons.add)),
      SideBarModel(title: " التوصيات", icon: Icon(Icons.list)),
      SideBarModel(title: "اضافة الحالات من مصدر خارجي", icon: Icon(Icons.add)),
      SideBarModel(title: "حجز جلسات", icon: Icon(Icons.border_color_outlined)),
      SideBarModel(title: "الجلسات المحجوزة", icon: Icon(Icons.list)),
      SideBarModel(title: "اضافة خدمة استشارية", icon: Icon(Icons.add)),
      SideBarModel(title: "الخدمات الاستشارية", icon: Icon(Icons.list)),
      SideBarModel(title: "اضافة استشاري", icon: Icon(Icons.add)),
    ];

    List<Widget> bodies = [
      StaticScreen(),
      AddPatientView(),
      AllPatientAdminView(),
      PointerReportView(),
      AdviceReportView(),
      AddQuestion(),
      AllQuestionView(),
      AddIndicator(),
      EditIndicator(),
      AddRecommend(),
      EditAdviceView(),
      Center(child: Text("اضافة الحالات من مصدر خارجي",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black))),
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
            automaticallyImplyLeading: isMobile,
            backgroundColor: Constants.theme.primaryColor,
            toolbarHeight: Constants.mediaQuery.height * 0.24,
            leadingWidth: Constants.mediaQuery.width * 0.3,
            leading: isMobile
                ? null
                : Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo2.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 10),
            title: Text(
              "العيادات المالية",
              style: Constants.theme.textTheme.titleLarge,
            ),
            actions: [
              LogoutView(),
            ],
            centerTitle: true,
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
                            style: Constants.theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                        Navigator.pop(context); // Close the drawer after selecting an item
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
                      color: Colors.black.withOpacity(0.86),
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
                                  color: currentIndex == index ? Colors.grey : Constants.theme.primaryColor.withOpacity(0.3),
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        titles[index].icon,
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            titles[index].title,
                                            style: currentIndex == index
                                                ? Constants.theme.textTheme.bodyLarge?.copyWith(color: Constants.theme.primaryColor, fontSize: 21)
                                                : Constants.theme.textTheme.bodyMedium,
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

