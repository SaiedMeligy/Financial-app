import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/initialPage/Services/manager/cubit.dart';
import 'package:experts_app/features/initialPage/Services/page/details_service_view.dart';
import 'package:experts_app/features/initialPage/Services/widget/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../homeAdmin/Consulting service/All Consultation/manager/cubit.dart';
import '../../../homeAdmin/Consulting service/All Consultation/manager/states.dart';
import '../../page/initial_page.dart';
import '../manager/states.dart';
import 'login_with_patient.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  var allConsultationCubit = AllConsultationCubit();
  var addService =AddServiceCubit();
  TextEditingController searchController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String searchQuery = '';
  var formKey = GlobalKey<FormState>();
  bool isLogged = false;

  @override
  void initState() {
    super.initState();
    isLogged=CacheHelper.isPationtLoggedIn();
     allConsultationCubit.getAllConsultationsPatient();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllConsultationCubit,AllConsultationStates>(
    bloc: allConsultationCubit,
      builder: (context, state) {
        if (state is LoadingAllConsultations) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessAllConsultations) {
          var consultation = state.consultationServices;
          var filteredConsultations =  consultation.where((consult) {
            return consult.name != null && consult.name!.contains(searchQuery);
          }).toList();
          return Form(
            key: formKey,
            child: Directionality(
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
                      SizedBox(height: 10,),
                      Container(
                  padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Constants.theme.primaryColor,
                          border: Border.all(
                            color: Colors.white70,
                          ),
                          borderRadius: BorderRadius.circular(20),

                        ),
                        child: 
                        (!isLogged)?TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPatient()));
                        }, child: Text("تسجيل الدخول",style: Constants.theme.textTheme.bodyLarge)
                        ):TextButton(onPressed: (){
                          CacheHelper.clearAllData();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPatient()));
                        }, child: Text("تسجيل الخروج",style: Constants.theme.textTheme.bodyLarge)
                        ),
                      ),
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
                            Navigator.push(context,MaterialPageRoute(builder: (context) => InitialPage(),));
                          }, icon: Icon(Icons.arrow_forward,size: 40,))

                        ],
                      ).setHorizontalPadding(context,enableMediaQuery: false, 50).setVerticalPadding(context,enableMediaQuery: false, 10),
                      BlocBuilder<AddServiceCubit,AddServiceStates>(
                        bloc: addService,
                        builder: (context, state) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                      'في حالة كانت الخدمة غير متوفرة يرجى كتابة اسم الخدمة وسيتم التواصل معك خلال 48 ساعة',
                                      style: Constants.theme.textTheme.titleLarge
                                          ?.copyWith(
                                          color: Colors.black,
                                          fontSize: 22
                                      )
                                  ).setHorizontalPadding(context, enableMediaQuery: false, 50).setVerticalPadding(context, enableMediaQuery: false, 5),
                                ],
                              ),
                              Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                               controller: descriptionController,
                              hint: "اضافة خدمة",
                              icon: Icons.search,
                              suffixWidget: Icon(Icons.search),
                                onValidate: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "من فضلك ادخل الخدمة المراد اضافتها";
                                  }
                                  return null;
                                }
                            ).setHorizontalPadding(context,enableMediaQuery: false, 20),
                          ),
                          ElevatedButton(onPressed: () {
                            if(formKey.currentState!.validate()){
                              if( CacheHelper.getData(key: 'id')!=null ){
                                addService.addService(descriptionController.text).then((value) {
                                  SnackBarService.showSuccessMessage("تم اضافة الخدمة");
                                });
                              }
                              else{
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPatient(),));
                              }

                            }
                          },
                          child:Text( "اضافة خدمة",style: Constants.theme.textTheme.bodyLarge,),style: ElevatedButton.styleFrom(backgroundColor: Constants.theme.primaryColor,padding: EdgeInsets.all(20)),)

                        ],
                      ).setHorizontalPadding(context,enableMediaQuery: false, 50).setVerticalPadding(context,enableMediaQuery: false, 10),
                            ],
                          );
                        }
                      ),
                      SizedBox(height: 20.0),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // Number of columns
                            crossAxisSpacing: 10, // Spacing between columns
                            mainAxisSpacing: 20, // Spacing between rows
                            childAspectRatio: 2.0, // Aspect ratio of each item
                          ),
                          itemCount: filteredConsultations.length, // Number of items
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
                                        Text(DividText(filteredConsultations[index].name??""),style: Constants.theme.textTheme.bodyLarge?.copyWith(fontSize: 22),),
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
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                          return DetailsServiceView(consultation: consultation[index],);
                                                        },));
                                                      },
                                                        child: Text('تفاصيل الخدمة',style: Constants.theme.textTheme.bodyMedium,)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            // GestureDetector(
                                            //   onTap: (){
                                            //     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPatient()));
                                            //   },
                                            //   child: Container(
                                            //     padding:EdgeInsets.all(8),
                                            //     decoration: BoxDecoration(
                                            //         borderRadius: BorderRadius.circular(10),
                                            //         border: Border.all(
                                            //           color: Colors.black,
                                            //         )
                                            //     ),
                                            //     child: Row(
                                            //       children: [
                                            //         Text('ابدأ الخدمة',style: Constants.theme.textTheme.bodyLarge,),
                                            //         SizedBox(width: 5,),
                                            //         Icon(Icons.arrow_forward,color: Colors.black,size: 20,),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),

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
                        ).setHorizontalPadding(context, enableMediaQuery: false, 20).setVerticalPadding(context,enableMediaQuery: false, 20),
                      )

                    ],
                  ),
                ),
              ),
          );

        } else if (state is ErrorAllConsultations) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );

  }
  String DividText (String text){
    String temp = "" ;
    List<String> Words = text.split(" ") ;
    if(Words.length > 4.5){
      for(int i=0; i<(Words.length/3).ceil();i++){
        temp += Words[i] + " " ;
      }
      temp = temp + "\n" ;
      for(int i=(Words.length/3).ceil(); i<Words.length;i++){
        temp += Words[i] + " " ;
      }
      return temp ;
    }


    return text ;

  }

}
