
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/config/page_route_name.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/initialPage/Services/page/services_view.dart';
import 'package:experts_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/config/cash_helper.dart';



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
            image: AssetImage('assets/images/clinic logo.jpg'),
            fit: BoxFit.cover,
            opacity: 0.9,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              navigatorKey.currentState!.pushNamed(PageRouteName.login);
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Empowering our community to live with hope \n throughout the journey with better life",
                            style: Constants.theme.textTheme.bodyMedium?.copyWith(
                              fontSize: isMobile ? 14 : 18,
                            ),
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
              height: isMobile ? 100 : Constants.mediaQuery.height * 0.17,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/clinic logo.jpg", fit: BoxFit.cover),
                    Row(
                      children: [
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
                                      // final Uri _url = Uri.parse('https://ssa.gov.ae/ar-AE/Services');
                                      // _launchURL(_url);
                                      Navigator.push(context, MaterialPageRoute(builder:(context) =>ServicesView()));
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
                        Image.asset("assets/images/لوجو الهيئة.png", fit: BoxFit.cover),
                      ],
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
    final String phoneNumber = '+971509414031';
    final Uri whatsappUri = Uri.parse('https://wa.me/$phoneNumber');

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $whatsappUri';
    }
  }



}
