import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/features/initialPage/Services/widget/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/widget/custom_text_field.dart';
import '../../../homeAdmin/Consulting service/All Consultation/manager/cubit.dart';
import 'login_with_patient.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  var allConsultationCubit = AllConsultationCubit();
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // allConsultationCubit.getAllConsultationsAdmin();
  }
  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<AllConsultationCubit,AllConsultationStates>(
    // bloc: allConsultationCubit,
    //   builder: (context, state) {
    //     if (state is LoadingAllConsultations) {
    //       return const Center(child: CircularProgressIndicator());
    //     } else if (state is SuccessAllConsultations) {
    //       var consultation = state.consultationServices;
    //       return Column(
    //         children: [
    //           Text(
    //               'الخدمات',
    //               style: Constants.theme.textTheme.titleLarge?.copyWith(
    //                   color: Colors.black
    //               )
    //           ),
    //           SizedBox(height: 20.0),
    //           Expanded(
    //               child: GridView.builder(
    //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                   crossAxisCount: 3,
    //                   crossAxisSpacing: 10,
    //                   mainAxisSpacing: 20,
    //                   childAspectRatio: 1.0,
    //                 ),
    //                 itemCount: 20, // Number of items
    //                 itemBuilder: (context, index) {
    //                   return SizedBox(
    //                     height: 100,
    //                     width: Constants.mediaQuery.width * 0.2,
    //                     child: BorderRoundedButton(
    //                       color: Colors.blueAccent,
    //                       title: 'Item $index',
    //                       onPressed: () {},
    //                     ),
    //                   ).setHorizontalPadding(
    //                       context, enableMediaQuery: false, 30);
    //                 },
    //               ).setHorizontalPadding(context, enableMediaQuery: false, 20)
    //           )
    //         ],
    //       );
    //     } else if (state is ErrorAllConsultations) {
    //       return Center(child: Text(state.errorMessage));
    //     }
    //     return const SizedBox.shrink();
    //   },
    // );
    return
      Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back.jpg'),
              fit: BoxFit.cover,
              opacity: 0.4
            )
          ),
          child: Column(
          children: [
            Row(
              children: [
                Text(
                    'الخدمات',
                    style: Constants.theme.textTheme.titleLarge?.copyWith(
                        color: Colors.black,
                      fontSize: 28
                    )
                ),
                Spacer(),
                Expanded(
                  child: CustomTextField(
                    controller: searchController,
                    hint: "البحث في الخدمات",

                    icon: Icons.search,
                    suffixWidget: Icon(Icons.search),
                  ).setHorizontalPadding(context,enableMediaQuery: false, 20),
                ),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_forward,size: 40,))

              ],
            ).setHorizontalPadding(context,enableMediaQuery: false, 50).setVerticalPadding(context,enableMediaQuery: false, 10),
            SizedBox(height: 20.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 10, // Spacing between columns
                  mainAxisSpacing: 20, // Spacing between rows
                  childAspectRatio: 2.0, // Aspect ratio of each item
                ),
                itemCount: 20, // Number of items
                itemBuilder: (context, index) {
                  Color containerColor = Constants.theme.primaryColor.withOpacity(0.8); // Initial color

                  return StatefulBuilder(
                    builder: (context, setState) {
                      return MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            containerColor = Color(0xff036173); // Change to hover color
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            containerColor = Constants.theme.primaryColor.withOpacity(0.8);; // Revert to initial color
                          });
                        },
                        child: RoundedButton(
                          color: containerColor, // Use the dynamic color
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Item $index',style: Constants.theme.textTheme.bodyLarge,),
                              SizedBox(height: 70,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding:EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black,
                                        )
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.info,color: Colors.black,size: 20,),
                                          SizedBox(width: 5,),
                                          Text('تفاصيل الخدمة',style: Constants.theme.textTheme.bodyMedium,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPatient()));
                                    },
                                    child: Container(
                                      padding:EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.black,
                                          )
                                      ),
                                      child: Row(
                                        children: [
                                          Text('ابدأ الخدمة',style: Constants.theme.textTheme.bodyLarge,),
                                          SizedBox(width: 5,),
                                          Icon(Icons.arrow_forward,color: Colors.black,size: 20,),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              )
                            ],
                          ),
                          onPressed: () {},
                        ).setHorizontalPadding(
                            context, enableMediaQuery: false, 30),
                      );
                    },
                  );
                },
              ).setHorizontalPadding(context, enableMediaQuery: false, 20),
            )

          ],
              ),
        ),
      );
  }
}
