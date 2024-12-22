import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/initialPage/Services/manager/cubit.dart';
import 'package:experts_app/features/initialPage/Services/page/details_service_view.dart';
import 'package:experts_app/features/initialPage/Services/widget/rounded_button.dart';
import 'package:flutter/material.dart';
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
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.theme.primaryColor,
              toolbarHeight: (Constants.mediaQuery.width < 600)
                  ? Constants.mediaQuery.height * 0.17
                  : Constants.mediaQuery.height * 0.24,
              leadingWidth: (Constants.mediaQuery.width < 600)
                  ? Constants.mediaQuery.height * 0.21
                  : Constants.mediaQuery.width * 0.35,
              leading: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InitialPage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: (Constants.mediaQuery.width < 600) ? 10 : 40,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/AEI Logo.png"),
                          fit: (Constants.mediaQuery.width < 600) ? BoxFit.fitWidth : BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 10),
              title: Column(
                children: [
                  Text(
                    (Constants.mediaQuery.width < 600) ? "العيادة \nالمالية" : "العيادة المالية",
                    style: (Constants.mediaQuery.width < 600)
                        ? Constants.theme.textTheme.bodyMedium
                        : Constants.theme.textTheme.titleLarge,
                  ),
                ],
              ),
              centerTitle: true,
              actions: [
                Container(
                  height: (Constants.mediaQuery.width < 600)
                      ? Constants.mediaQuery.height * 0.10
                      : Constants.mediaQuery.height * 0.6,
                  width: (Constants.mediaQuery.width < 600)
                      ? Constants.mediaQuery.height * 0.12
                      : Constants.mediaQuery.width * 0.29,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage("assets/images/لوجو الهيئة.png"),
                      fit: (Constants.mediaQuery.width < 600) ? BoxFit.fitWidth : BoxFit.cover,
                    ),
                  ),
                ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 10),
              ],
            ),
            body: 
            SingleChildScrollView(
                child: SizedBox(
                  height: (Constants.mediaQuery.width<600)?Constants.mediaQuery.height*3.5:Constants.mediaQuery.height*2.2,
                  child: Form(
                  key: formKey,
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: const AssetImage('assets/images/back.jpg'),
                                fit: BoxFit.cover,
                                opacity:(Constants.mediaQuery.width < 600)?0.2: 0.2
                            )
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Constants.theme.primaryColor,
                                    border: Border.all(
                                      color: Colors.white70,
                                    ),
                                    borderRadius: BorderRadius.circular(20),

                                  ),
                                  child:
                                  (!isLogged)?Row(
                                    children: [
                                      TextButton(onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPatient()));
                                      }, child: Text("تسجيل الدخول",style: (Constants.mediaQuery.width < 600)?Constants.theme.textTheme.bodyMedium:Constants.theme.textTheme.bodyLarge)
                                      ),
                                    ],
                                  ):TextButton(onPressed: (){
                                    CacheHelper.clearAllData();
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPatient()));
                                  }, child: Text("تسجيل الخروج",style: (Constants.mediaQuery.width < 600)?Constants.theme.textTheme.bodyMedium:Constants.theme.textTheme.bodyLarge)
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            (Constants.mediaQuery.width < 600)?Row(
                              children: [
                                Text(
                                    'الخدمات',
                                    style:(Constants.mediaQuery.width < 600)?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black):Constants.theme.textTheme.titleLarge?.copyWith(
                                        color: Colors.black,
                                        fontSize: 28,
                                      fontWeight: FontWeight.bold
                                    )
                                ),
                                Expanded(
                                  child: CustomTextField(
                                    controller: searchController,
                                    hint: "البحث في الخدمات",
                                    icon: Icons.search,
                                    suffixWidget: const Icon(Icons.search),

                                  ).setHorizontalPadding(context,enableMediaQuery: false, 20),
                                ),
                              ],
                            ).setHorizontalPadding(context,enableMediaQuery: false, 50).setVerticalPadding(context,enableMediaQuery: false, 10)
                                :Row(
                              children: [
                                Text(
                                    'الخدمات',
                                    style:(Constants.mediaQuery.width < 600)?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black):Constants.theme.textTheme.titleLarge?.copyWith(
                                        color: Colors.black,
                                        fontSize: 28
                                    )
                                ),
                                const Spacer(),
                                Expanded(
                                  child: CustomTextField(
                                    controller: searchController,
                                    hint: "البحث في الخدمات",
                                    icon: Icons.search,
                                    suffixWidget: const Icon(Icons.search),

                                  ).setHorizontalPadding(context,enableMediaQuery: false, 20),
                                ),

                              ],
                            ).setHorizontalPadding(context,enableMediaQuery: false, 50).setVerticalPadding(context,enableMediaQuery: false, 10),
                            BlocBuilder<AddServiceCubit,AddServiceStates>(
                              bloc: addService,
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    (Constants.mediaQuery.width < 600)?Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              'في حالة كانت الخدمة غير متوفرة يرجى كتابة اسم الخدمة وسيتم التواصل معك خلال 48 ساعة',
                                              style: Constants.theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 20
                                              )
                                          ).setHorizontalPadding(context, enableMediaQuery: false, 50).setVerticalPadding(context, enableMediaQuery: false, 5),
                                        ),
                                      ],
                                    ):Row(
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
                                    suffixWidget: const Icon(Icons.search),
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginWithPatient(),));
                                    }

                                  }
                                },style: ElevatedButton.styleFrom(backgroundColor: Constants.theme.primaryColor,padding: EdgeInsets.all(20)),
                                child:Text( "اضافة خدمة",style: (Constants.mediaQuery.width < 600)?Constants.theme.textTheme.bodySmall:Constants.theme.textTheme.bodyLarge,),)

                              ],
                            ).setHorizontalPadding(context,enableMediaQuery: false, 50).setVerticalPadding(context,enableMediaQuery: false, 10),
                                  ],
                                );
                              }
                            ),
                            const SizedBox(height: 20.0),
                            Expanded(
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (Constants.mediaQuery.width < 600) ? 1 : 3,
                                  crossAxisSpacing: (Constants.mediaQuery.width < 600)?5:10,
                                  mainAxisSpacing: (Constants.mediaQuery.width < 600)?5:20,
                                  childAspectRatio: (Constants.mediaQuery.width < 600)?3:2.0,
                                ),
                                itemCount: filteredConsultations.length, // Number of items
                                itemBuilder: (context, index) {
                                  Color containerColor = Constants.theme.primaryColor.withOpacity(0.8);

                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return MouseRegion(
                                        onEnter: (_) {
                                          setState(() {
                                            containerColor = const Color(0xff036173); // Change to hover color
                                          });
                                        },
                                        onExit: (_) {
                                          setState(() {
                                            containerColor = Constants.theme.primaryColor.withOpacity(0.8); // Revert to initial color
                                          });
                                        },
                                        child: RoundedButton(
                                          color: containerColor,
                                          title: Expanded(
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text((Constants.mediaQuery.width < 600)?filteredConsultations[index].name??"":DividText(filteredConsultations[index].name??""),style:(Constants.mediaQuery.width < 600)?Constants.theme.textTheme.bodyMedium :Constants.theme.textTheme.bodyLarge?.copyWith(fontSize: 22),),
                                                  (Constants.mediaQuery.width < 600)?const SizedBox(height: 10,):SizedBox(height: 70,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          padding:const EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10),
                                                              border: Border.all(
                                                                color: Colors.black,
                                                              )
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              const Icon(Icons.info,color: Colors.black,size: 20,),
                                                              const SizedBox(width: 5,),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                    return DetailsServiceView(consultation: consultation[index],);
                                                                  },));
                                                                },
                                                                  child: Text('تفاصيل الخدمة',style: (Constants.mediaQuery.width < 600)?Constants.theme.textTheme.bodySmall:Constants.theme.textTheme.bodyMedium,)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 20),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
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

