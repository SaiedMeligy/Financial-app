
import 'package:experts_app/core/config/app_theme_manager.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/pages/AllSessionEvalutionView.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/pages/PointerTypeEvalutionView.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/pages/PointerTypesView.dart';
import 'package:experts_app/features/homeAdmin/widget/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/config/cash_helper.dart';
import '../../core/config/constants.dart';
import '../../core/excel_exportation/RecordsTableWidget.dart';
import 'logout/page/logout_view.dart';
class HomeAdminView extends StatefulWidget {
  const HomeAdminView({super.key,this.targetIndex = 0});
  final int targetIndex;
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
    currentIndex = widget.targetIndex;

  }
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        isMobile = constraints.maxWidth < 600;

        return Scaffold(
          appBar: AppBar(
            shape: Border(
              bottom: BorderSide(
                color: AppThemeManager.borderColor,
                width: 2.5
              )
            ),
            backgroundColor: Constants.theme.primaryColor,
            toolbarHeight: 90,
            leadingWidth: Constants.mediaQuery.width * 0.30,
            leading: isMobile? null : Row(
              children: [
                SizedBox(width: 20,),
                Container(
                  width: 207,
                  height: 76.5,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/AEI Logo.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            // title: Column(
            //   children: [
            //     Text(
            //       isMobile?"العيادة \nالمالية":"العيادة المالية",
            //       style: isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold):Constants.theme.textTheme.titleLarge,
            //     ),
            //     SizedBox(height: 15,),
            //     Text(
            //       "$admin_name",
            //       style: isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold):Constants.theme.textTheme.titleLarge,
            //     ),
            //   ],
            // ),
            centerTitle: true,
            actions: [
               isMobile ? Container() : Row(
                 children: [
                   Text(
                     "$admin_name",
                     style: Constants.theme.textTheme.bodyMedium!.copyWith(color: Colors.black) ,
                   ),
                   SizedBox(width: 10,),
                   LogoutView(),
                   SizedBox(width: 20,),
                   // IconButton(
                   //   onPressed: () {
                   //     showDialog(context: context, builder: (context) {
                   //       return Container(
                   //         child: AlertDialog(
                   //           backgroundColor: Colors.black,
                   //           content:SizedBox(
                   //               width: Constants.mediaQuery.width*0.4,
                   //               height: Constants.mediaQuery.width*0.10,
                   //
                   //               child: RecordsTableWidget()),
                   //           actions: [
                   //             TextButton(
                   //               onPressed: () {
                   //                 Navigator.of(context).pop();
                   //               },
                   //               child: Container(
                   //                   decoration: BoxDecoration(
                   //                     borderRadius: BorderRadius.circular(10),
                   //                     border: Border.all(
                   //                       color: Constants.theme.primaryColor,
                   //                       width: 2.5,
                   //                     ),
                   //                   ),
                   //                   child: Text("اغلاق",
                   //                     style: Constants.theme.textTheme.bodyMedium
                   //                         ?.copyWith(
                   //                         color: Colors.white
                   //                     ),
                   //                   ).setHorizontalPadding(
                   //                       context,
                   //                       enableMediaQuery: false, 20)
                   //               ),
                   //             ),
                   //           ],
                   //         ),
                   //       );
                   //     });
                   //   },
                   //   icon: Icon(
                   //     Icons.download_rounded
                   //   )
                   // ),
                 ],
               )
              // Container(
              //    width: 207,
              //    height: 76.5,
              //    padding: const EdgeInsets.all(10),
              //    decoration: const BoxDecoration(
              //      color: Colors.white,
              //      borderRadius: BorderRadius.all(Radius.circular(10)),
              //      image: DecorationImage(
              //        image: AssetImage("assets/images/لوجو الهيئة.png"),
              //        fit: BoxFit.contain,
              //      ),
              //    ),
              // ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 10),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     // LogoutView(),
              //     // Row(
              //     //   children: [
              //     //     Text("نسخ احتياطي",style: Constants.theme.textTheme.bodyMedium,),
              //     //     IconButton(
              //     //       onPressed: () {
              //     //         showDialog(context: context, builder: (context) {
              //     //         return Container(
              //     //           child: AlertDialog(
              //     //             backgroundColor: Colors.black,
              //     //             content:SizedBox(
              //     //                 width: Constants.mediaQuery.width*0.4,
              //     //                 height: Constants.mediaQuery.width*0.10,
              //     //
              //     //                 child: RecordsTableWidget()),
              //     //             actions: [
              //     //               TextButton(
              //     //                 onPressed: () {
              //     //                   Navigator.of(context).pop();
              //     //                 },
              //     //                 child: Container(
              //     //                   decoration: BoxDecoration(
              //     //                     borderRadius: BorderRadius.circular(10),
              //     //                     border: Border.all(
              //     //                       color: Constants.theme.primaryColor,
              //     //                       width: 2.5,
              //     //                     ),
              //     //                   ),
              //     //                   child: Text("اغلاق",
              //     //                     style: Constants.theme.textTheme.bodyMedium
              //     //                         ?.copyWith(
              //     //                           color: Colors.white
              //     //                         ),
              //     //                   ).setHorizontalPadding(
              //     //                       context,
              //     //                       enableMediaQuery: false, 20)
              //     //                 ),
              //     //               ),
              //     //             ],
              //     //           ),
              //     //         );
              //     //       });
              //     //       },
              //     //       icon: Icon(Icons.download_rounded)
              //     //     ),
              //     //   ],
              //     // ),
              //   ],
              // )
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
                ...Constants.titles.map((title) {
                  int index = Constants.titles.indexOf(title);
                  return ListTile(
                    title: Row(
                      children: [
                        Constants.titles[index].icon,
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            Constants.titles[index].title,
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
                    width: Constants.mediaQuery.width * 0.18,
                    decoration: BoxDecoration(
                      color: AppThemeManager.drawerColor ,
                      border: Border(
                        left: BorderSide(
                          color: AppThemeManager.borderColor ,
                          width: 2.5
                        )
                      )
                    ),
                    child: DrawerWidget(
                      currentIndex: currentIndex ,
                      onTap: (index) {
                        setState(() {
                         currentIndex = index;
                        });
                      },
                    )
                  ),
                Expanded(
                  child: Container(
                    color: Constants.theme.primaryColor.withOpacity(0.3),
                    child: Constants.bodies[currentIndex],
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

