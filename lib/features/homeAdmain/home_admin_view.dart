
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/domain/entities/side_bar_model.dart';
import 'package:experts_app/features/homeAdmain/registrationAdvisor/page/register_view.dart';
import 'package:experts_app/features/homeAdmain/staticScreen/page/static_screen.dart';
import 'package:flutter/material.dart';

import '../../core/config/constants.dart';
import 'Consulting service/All Consultation/page/consulting_view.dart';
import 'Consulting service/Consultation Store/page/add_consulting.dart';
import 'Recommendations/page/edit_recommend_view.dart';
import 'Recommendations/page/recommend_view.dart';
import 'indicators/page/add_indicator.dart';
import 'indicators/page/edit_indicator.dart';
import 'logout/page/logout_view.dart';
import 'question/pages/add_question.dart';

class HomeAdminView extends StatefulWidget {
  const HomeAdminView({super.key});

  @override
  State<HomeAdminView> createState() => _HomeAdminViewState();
}

class _HomeAdminViewState extends State<HomeAdminView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<SideBarModel> titles = [
      SideBarModel(title: "الصفحة الرئيسية", icon: Icon(Icons.home)),
      SideBarModel(title: "اضافة حالة", icon: Icon(Icons.add)),
      SideBarModel(title: "الحالات", icon: Icon(Icons.list)),
      SideBarModel(title: "تقارير المؤاشرات", icon: Icon(Icons.list)),
      SideBarModel(title: "اضافة الأسئلة", icon: Icon(Icons.add)),
      SideBarModel(title: "اضافة المؤاشرات", icon: Icon(Icons.add)),
      SideBarModel(title: "تعديل المؤاشرات", icon: Icon(Icons.edit)),
      SideBarModel(title: "اضافة التوصيات", icon: Icon(Icons.add)),
      SideBarModel(title: "تعديل التوصيات", icon: Icon(Icons.edit)),
      SideBarModel(title: "اضافة الحالات من مصدر خارجي", icon: Icon(Icons.add)),
      SideBarModel(title: "حجز جلسات", icon: Icon(Icons.border_color_outlined)),
      SideBarModel(title: "الجلسات المحجوزة", icon: Icon(Icons.list)),
      SideBarModel(title: "تسجيل استشاري", icon: Icon(Icons.edit)),
      SideBarModel(title: "اضافة خدمة استشارية", icon: Icon(Icons.add)),
      SideBarModel(title: "الخدمات الاستشارية", icon: Icon(Icons.list)),
      SideBarModel(title: "اضافة استشاري", icon: Icon(Icons.add)),

    ];
    List<Widget> bodies = [
      StaticScreen(),
      Center(child: Text("اضافة حالة",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black))),
      Center(child: Text("الحالات",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black))),
      Center(child: Text("تقارير المؤاشرات",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black))),
      AddQuestion(),
      AddIndicator(),
      EditIndicator(),
      AddRecommend(),
      EditRecommendView(),
      Center(child: Text("اضافة الحالات من مصدر خارجي",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black))),
      Center(child: Text("حجز جلسات",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),),),
      Center(child: Text("الجلسات المحجوزة",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),),),
      Center(child: Text("تسجيل استشاري",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),),),
      AddConsulting(),
      ConsultingView(),
      RegisterView(),
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
              //borderRadius: BorderRadius.all(Radius.circular(10)),
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
              //height: Constants.mediaQuery.height*0.7,
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
                                // leading: currentIndex == index
                                //     ? const VerticalDivider(
                                //         color: Color(0xff004182),
                                //         indent: 2,
                                //         thickness: 4,
                                //         endIndent: 2,
                                //       )
                                //     : null,
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
