// import 'package:experts_app/core/config/constants.dart';
// import 'package:experts_app/core/config/page_route_name.dart';
// import 'package:experts_app/core/extensions/padding_ext.dart';
// import 'package:experts_app/main.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:responsive_builder/responsive_builder.dart';
//
// class InitialPage extends StatefulWidget {
//   const InitialPage({super.key});
//
//   @override
//   State<InitialPage> createState() => _InitialPageState();
// }
//
// class _InitialPageState extends State<InitialPage> {
//   bool isMobile = false;
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         isMobile = constraints.maxWidth < 600;
//
//         return
//           Scaffold(
//             body:
//             Stack(
//                 fit: StackFit.passthrough,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           image: const DecorationImage(
//                             image: AssetImage('assets/images/back.jpg'),
//                             fit: BoxFit.cover,
//                             opacity: 0.9
//                           )
//                       ),
//                       child:
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//
//                           Container(
//                             width: 80,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: Constants.theme.primaryColor.withOpacity(0.6),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "We think extraordinary \n people deserve \n extraordinary care ",
//                                   style: Constants.theme.textTheme.titleLarge
//                                       ?.copyWith(
//                                     fontSize: 35,
//                                     fontWeight: FontWeight.w500,
//
//                                   ),
//                                 ),
//                                 SizedBox(height: 15,),
//                                 Text(
//                                   "Empowering our community to live with hope \n throughout the journey with better live",
//                                   style: Constants.theme.textTheme.bodyMedium,),
//                                 SizedBox(height: 15,),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                         width: Constants.mediaQuery.width * 0.2,
//                                         child: ElevatedButton(onPressed: () {
//                                           navigatorKey.currentState!.pushReplacementNamed(PageRouteName.login);
//                                         },
//                                             child: Text("Get Started",
//                                               style: Constants.theme.textTheme
//                                                   .bodyMedium?.copyWith(
//                                                   color: Colors.black
//                                               ),))),
//                                   ],
//                                 ),
//                               ],
//                             ).setHorizontalPadding(context,enableMediaQuery: false, 20).setVerticalPadding(context,enableMediaQuery: false, 20),
//                           ).setOnlyPadding(context,enableMediaQuery: false, 0, 0, 800, 0)
//                         ],
//
//                       ).setHorizontalPadding(
//                           context, enableMediaQuery: false, 40)
//
//                   ),
//                   Container(
//                     height: Constants.mediaQuery.height * 0.15,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       //borderRadius: BorderRadius.circular(20)
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                       children: [
//                         Image.asset("assets/images/logo.jpg", fit: BoxFit.cover,
//                         ),
//                         Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//
//                                   Image.asset("assets/images/youtube.png",
//                                     fit: BoxFit.cover, height: 24, width: 24,),
//                                   SizedBox(width: 10,),
//                                   Image.asset("assets/images/instagram.jpg",
//                                     fit: BoxFit.cover, height: 20, width: 20,),
//                                   SizedBox(width: 10,),
//                                   Image.asset("assets/images/twitter.png",
//                                     fit: BoxFit.cover, height: 20, width: 20,),
//                                   SizedBox(width: 10,),
//                                   Image.asset("assets/images/linkedin.png",
//                                     fit: BoxFit.cover, height: 20, width: 20,),
//                                   SizedBox(width: 10,),
//                                   Image.asset("assets/images/fasebook.png",
//                                     fit: BoxFit.cover, height: 20, width: 20,),
//                                   SizedBox(width: 10,),
//                                   Container(
//                                     height: 25,
//                                     width: 1,
//                                     color: Colors.grey,
//                                   ),
//                                   IconButton(
//                                       onPressed: () {},
//                                       icon: Icon(Icons.search)),
//                                   TextButton(onPressed: () {},
//                                     child: Text("اتصل بنا",
//                                       style: Constants.theme.textTheme.bodyLarge
//                                           ?.copyWith(
//                                           color: Colors.black
//                                       ),),),
//                                   // TextButton(onPressed: () {},
//                                   //   child: Text("لمقدمي الرعاية",
//                                   //     style: Constants.theme.textTheme.bodyLarge
//                                   //         ?.copyWith(
//                                   //         color: Colors.black),),),
//                                   // TextButton(onPressed: () {},
//                                   //   child: Text("المتطوع",
//                                   //     style: Constants.theme.textTheme.bodyLarge
//                                   //         ?.copyWith(
//                                   //         color: Colors.black),),),
//
//                                 ],
//                               ),
//                               // Row(
//                               //   mainAxisAlignment: MainAxisAlignment.end,
//                               //   children: [
//                               //
//                               //     TextButton(onPressed: () {},
//                               //       child: Text("اتصل بنا",
//                               //         style: Constants.theme.textTheme.bodyLarge
//                               //             ?.copyWith(
//                               //             color: Colors.black
//                               //         ),),),
//                               //     // TextButton(onPressed: () {},
//                               //     //   child: Text("مركز الحالات",
//                               //     //     style: Constants.theme.textTheme.bodyLarge
//                               //     //         ?.copyWith(
//                               //     //         color: Colors.black),),),
//                               //     // TextButton(onPressed: () {},
//                               //     //   child: Text("الخدمات",
//                               //     //     style: Constants.theme.textTheme.bodyLarge
//                               //     //         ?.copyWith(
//                               //     //         color: Colors.black),),),
//                               //     // TextButton(onPressed: () {},
//                               //     //   child: Text("التوظيف",
//                               //     //     style: Constants.theme.textTheme.bodyLarge
//                               //     //         ?.copyWith(
//                               //     //         color: Colors.black
//                               //     //     ),),),
//                               //     // TextButton(onPressed: () {},
//                               //     //   child: Text("معلومات عنا",
//                               //     //     style: Constants.theme.textTheme.bodyLarge
//                               //     //         ?.copyWith(
//                               //     //         color: Colors.black),),),
//                               //   ],
//                               // )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//
//                 ]
//
//
//             )
//                 .setHorizontalPadding(context, enableMediaQuery: false, 30)
//                 .setVerticalPadding(context, enableMediaQuery: false, 30),
//           );
//       }
//     );
//
//
//
//   }
// }

import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/config/page_route_name.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';



class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  bool isMobile = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
      isMobile = constraints.maxWidth < 600;
      return isMobile ?  Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/back.jpg'),
            fit: BoxFit.cover,
            opacity: 0.9,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              navigatorKey.currentState!.pushReplacementNamed(PageRouteName.login);
            },
            child: Text(
              "Get Started",
              style: Constants.theme.textTheme.bodyMedium?.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ):
      Scaffold(
        body: Stack(
          fit: StackFit.passthrough,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/images/back.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.9,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: isMobile ? double.infinity : 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Constants.theme.primaryColor.withOpacity(0.6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Empowering our community to live with hope \n throughout the journey with better life",
                          style: Constants.theme.textTheme.bodyMedium?.copyWith(
                            fontSize: isMobile ? 14 : 18,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: isMobile ? double.infinity : Constants.mediaQuery.width * 0.2,
                          child: ElevatedButton(
                            onPressed: () {
                              navigatorKey.currentState!.pushReplacementNamed(PageRouteName.login);
                            },
                            child: Text(
                              "Get Started",
                              style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).setHorizontalPadding(context, enableMediaQuery: false, isMobile ? 10 : 20)
                        .setVerticalPadding(context, enableMediaQuery: false, isMobile ? 10 : 20),
                  ).setOnlyPadding(context, enableMediaQuery: false, isMobile ? 0 : 0, 0, 800, 0),
                ],
              ).setHorizontalPadding(context, enableMediaQuery: false, isMobile ? 20 : 40),
            ),
            Container(
              height: isMobile ? 100 : Constants.mediaQuery.height * 0.15,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/logo.jpg", fit: BoxFit.cover),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //Image.asset("assets/images/youtube.png", fit: BoxFit.cover, height: 24, width: 24),
                            IconButton(onPressed: (){
                              final Uri _url = Uri.parse('https://ssa.gov.ae/');
                              _launchURL(_url);
                            }, icon: Icon(Icons.home,size: 30,color:Colors.black)),
                            GestureDetector(
                              onTap: (){
                                final Uri _url = Uri.parse('https://www.instagram.com/abudhabissa?igsh=MTV5bjhpdnJ2YXdjNw==');
                                _launchURL(_url);
                              },
                                child: Image.asset("assets/images/instagram.jpg", fit: BoxFit.cover, height: 30, width: 30)),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                final Uri _url = Uri.parse('https://www.youtube.com/channel/UCrxFgacyJ9CYpgiujg1HQUg');
                                _launchURL(_url);
                              },
                                child: Image.asset("assets/images/youtube.png", fit: BoxFit.cover, height: 25, width: 20)),
                            const SizedBox(width: 10),
                            //Image.asset("assets/images/linkedin.png", fit: BoxFit.cover, height: 20, width: 20),
                            const SizedBox(width: 10),
                            Container(
                              height: 25,
                              width: 1,
                              color: Colors.grey,
                            ),
                            TextButton(
                              onPressed: () {
                                final Uri _url = Uri.parse('https://ssa.gov.ae/ar-AE/Services');
                                _launchURL(_url);
                              },
                              child: Text(
                                "خدماتنا",
                                style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _launchWhatsApp();
                              },
                              child: Text(
                                "اتصل بنا",
                                style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).setHorizontalPadding(context, enableMediaQuery: false, isMobile ? 10 : 30)
            .setVerticalPadding(context, enableMediaQuery: false, isMobile ? 10 : 30),
      );
      },
    );
  }
  void _launchURL(Uri url) async {
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
  void _launchWhatsApp() async {
    final String phoneNumber = '0509414031';
    final Uri whatsappUri = Uri.parse('https://wa.me/$phoneNumber');

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $whatsappUri';
    }
  }



}
