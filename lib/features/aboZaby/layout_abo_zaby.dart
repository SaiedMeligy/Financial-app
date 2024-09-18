

import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/aboZaby/allPatientsWithAbozaby/page/all_patient_abozaby_view.dart';
import 'package:experts_app/features/aboZaby/home/page/home_abo_zaby.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/config/cash_helper.dart';
import '../../core/config/constants.dart';
import '../../domain/entities/side_bar_model.dart';
import '../homeAdmin/allPatientsAdmin/page/all_patient_admin_view.dart';
import '../homeAdmin/logout/page/logout_view.dart';
import '../homeAdmin/staticScreen/page/static_screen.dart';

class LayoutAboZabyView extends StatefulWidget {
  const LayoutAboZabyView({super.key});

  @override
  State<LayoutAboZabyView> createState() => _LayoutAboZabyViewState();
}

class _LayoutAboZabyViewState extends State<LayoutAboZabyView> {
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
      SideBarModel(title: "الحالات", icon: Icon(Icons.list,color: Colors.black87)),

    ];

    List<Widget> bodies = [
      HomeAboZaby(),
      AllPatientAbozabyView(),

    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        isMobile = constraints.maxWidth < 600;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.theme.primaryColor,
            toolbarHeight: Constants.mediaQuery.height * 0.26,
            leadingWidth: Constants.mediaQuery.width * 0.35,
            leading: isMobile?null:Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/images/AEI Logo.png"),
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
                  isMobile?"العيادة \nالمالية":"العيادة المالية",
                  style: isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold):Constants.theme.textTheme.titleLarge,
                ),
                SizedBox(height: 15,),
                Text(
                  "$admin_name",
                  style: isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold):Constants.theme.textTheme.titleLarge,
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              isMobile?Container():Container(
                height: Constants.mediaQuery.height*0.6,
                width: Constants.mediaQuery.width*0.29,
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
          drawer: isMobile ? Drawer(
            backgroundColor: Constants.theme.primaryColor,
            child: ListView(
              children: [
                DrawerHeader(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Constants.theme.primaryColor,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/AEI Logo.png",),
                        fit: BoxFit.fitWidth,
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
                Divider(color: Colors.white70,),
                Padding(
                  padding: const EdgeInsets.only(right: 10,top: 0,bottom: 10,left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))

                    ),
                    child: Image.asset("assets/images/لوجو الهيئة.png",
                      fit: BoxFit.fitWidth,
                      height: 80,// Adjust height as needed
                    ),
                  ),
                ).setVerticalPadding(context,enableMediaQuery: false, 10)
              ],
            ),
          ) : null,
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

