  import 'package:experts_app/core/config/constants.dart';
  import 'package:experts_app/core/config/page_route_name.dart';
  import 'package:experts_app/core/extensions/padding_ext.dart';
  import 'package:experts_app/features/initialPage/Services/page/services_view.dart';
import 'package:experts_app/features/initialPage/page/complaint_page.dart';
  import 'package:experts_app/main.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/widgets.dart';
  import 'dart:html' as html;
  import 'package:font_awesome_flutter/font_awesome_flutter.dart';



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
            return isMobile
                ? Scaffold(
              body: Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                    decoration: BoxDecoration(
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
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Constants.theme.primaryColor.withOpacity(
                                0.6),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Empowering our community to live with hope \n throughout the journey with better life",
                                  style: Constants.theme.textTheme.bodyMedium
                                      ?.copyWith(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    navigatorKey.currentState!
                                        .pushReplacementNamed(
                                        PageRouteName.login);
                                  },
                                  child: Text(
                                    "Get Started",
                                    style: Constants
                                        .theme.textTheme.bodyMedium
                                        ?.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ServicesView()));
                                  },
                                  child: Text(
                                    "خدمات المستفيد",
                                    style: Constants
                                        .theme.textTheme.bodyMedium
                                        ?.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                              .setHorizontalPadding(
                              context,
                              enableMediaQuery: false,
                              10)
                              .setVerticalPadding(
                              context,
                              enableMediaQuery: false,
                              10),
                        ),
                      ],
                    ).setHorizontalPadding(
                        context, enableMediaQuery: false, 20),
                  ),
                  Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 200,
                            child: Image.asset("assets/images/clinic logo.jpg",
                                fit: BoxFit.fitWidth),
                          ),
                          SizedBox(width: 5,),
                          Row(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              final Uri _url = Uri.parse(
                                                  'https://ssa.gov.ae/');
                                              _launchURL(_url);
                                            },
                                            child: Icon(Icons.home, size: 15, color: Colors.black)),
                                        const SizedBox(width: 3),
                                        GestureDetector(
                                            onTap: () {
                                              final Uri _url = Uri.parse(
                                                  'https://www.instagram.com/abudhabissa?igsh=MTV5bjhpdnJ2YXdjNw==');
                                              _launchURL(_url);
                                            },
                                            child: Icon(FontAwesomeIcons.instagram, color: Colors.purple, size: 15)),
                                        const SizedBox(width: 2),
                                        GestureDetector(
                                            onTap: () {
                                              final Uri _url = Uri.parse(
                                                  'https://www.youtube.com/channel/UCrxFgacyJ9CYpgiujg1HQUg');
                                              _launchURL(_url);
                                            },
                                            child: Icon(FontAwesomeIcons.youtube, color: Colors.red, size: 15),
                                        ),
                                        const SizedBox(width: 5),
                                        Container(
                                          height: 25,
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _launchWhatsApp();
                                          },
                                          child: Text(
                                            "اتصل بنا",
                                            style: (Constants.mediaQuery.width < 600)?Constants.theme.textTheme.bodySmall?.copyWith(color: Colors.black,fontWeight: FontWeight.bold):Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintPage(),));
                                      },
                                      child: Text(
                                        "المقترحات والشكاوى",
                                        style: (Constants.mediaQuery.width < 600)?Constants.theme.textTheme.bodySmall?.copyWith(color: Colors.black,fontWeight: FontWeight.bold):Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Image.asset("assets/images/لوجو الهيئة.png",
                                  fit: BoxFit.cover),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).setHorizontalPadding(context, enableMediaQuery: false, 10)
                  .setVerticalPadding(context, enableMediaQuery: false, 10),
            )
                : Scaffold(
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
                            color:
                            Constants.theme.primaryColor.withOpacity(0.6),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Empowering our community to live with hope \n throughout the journey with better life",
                                  style: Constants.theme.textTheme.bodyMedium
                                      ?.copyWith(
                                    fontSize: isMobile ? 14 : 18,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                width: isMobile
                                    ? double.infinity
                                    : Constants.mediaQuery.width * 0.2,
                                child: ElevatedButton(
                                  onPressed: () {
                                    navigatorKey.currentState!
                                        .pushReplacementNamed(
                                        PageRouteName.login);
                                  },
                                  child: Text(
                                    "Get Started",
                                    style: Constants
                                        .theme.textTheme.bodyMedium
                                        ?.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: isMobile
                                    ? double.infinity
                                    : Constants.mediaQuery.width * 0.2,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // final Uri _url = Uri.parse('https://ssa.gov.ae/ar-AE/Services');
                                    // _launchURL(_url);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ServicesView()));
                                  },
                                  child: Text(
                                    "خدمات المستفيد",
                                    style: Constants
                                        .theme.textTheme.bodyMedium
                                        ?.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                              .setHorizontalPadding(
                              context,
                              enableMediaQuery: false,
                              isMobile ? 10 : 20)
                              .setVerticalPadding(
                              context,
                              enableMediaQuery: false,
                              isMobile ? 10 : 20),
                        ).setOnlyPadding(
                            context,
                            enableMediaQuery: false,
                            isMobile ? 0 : 0,
                            0,
                            800,
                            0),
                      ],
                    ).setHorizontalPadding(
                        context, enableMediaQuery: false, isMobile ? 20 : 40),
                  ),
                  Container(
                    height:
                    isMobile ? 100 : Constants.mediaQuery.height * 0.17,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/images/clinic logo.jpg",
                            fit: BoxFit.cover),
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
                                      IconButton(
                                          onPressed: ()  {
                                            final Uri _url = Uri.parse(
                                                'https://ssa.gov.ae/');
                                            _launchURL(_url);
                                          },
                                          icon: Icon(Icons.home,
                                              size: 30, color: Colors.black)),
                                      GestureDetector(
                                          onTap: ()  {
                                            final Uri _url = Uri.parse(
                                                'https://www.instagram.com/abudhabissa?igsh=MTV5bjhpdnJ2YXdjNw==');
                                            _launchURL(_url);
                                          },
                                          child: Icon(FontAwesomeIcons.instagram, color: Colors.purple, size: 30)),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                          onTap: ()  {
                                            final Uri _url = Uri.parse(
                                                'https://www.youtube.com/channel/UCrxFgacyJ9CYpgiujg1HQUg');
                                            _launchURL(_url);
                                          },
                                          child: Icon(FontAwesomeIcons.youtube, color: Colors.red, size: 30)
                                      ),
                                      const SizedBox(width: 10),
                                      //Image.asset("assets/images/linkedin.png", fit: BoxFit.cover, height: 20, width: 20),
                                      const SizedBox(width: 10),
                                        Container(
                                        height: 25,
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      // TextButton(
                                      //   onPressed: () {
                                      //     // final Uri _url = Uri.parse('https://ssa.gov.ae/ar-AE/Services');
                                      //     // _launchURL(_url);
                                      //     Navigator.push(context, MaterialPageRoute(builder:(context) =>ServicesView()));
                                      //   },
                                      //   child: Text(
                                      //     "خدماتنا",
                                      //     style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                                      //   ),
                                      // ),
                                      TextButton(
                                        onPressed: ()  {
                                          _launchWhatsApp();
                                        },
                                        child: Text(
                                          "اتصل بنا",
                                          style: Constants
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: ()  {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintPage(),));

                                        },
                                        child: Text(
                                          "المقترحات والشكاوى",
                                          style: Constants
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Image.asset("assets/images/لوجو الهيئة.png",
                                fit: BoxFit.cover),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  .setHorizontalPadding(
                  context, enableMediaQuery: false, isMobile ? 10 : 30)
                  .setVerticalPadding(
                  context, enableMediaQuery: false, isMobile ? 10 : 30),
            );
            // Your existing desktop layout code here
          }
      );
    }
    void _launchURL(Uri url) {
      html.window.open(url.toString(), '_blank');
    }
    void _launchWhatsApp() {
      final String phoneNumber = '+971509414031';
      final Uri whatsappUri = Uri.parse('https://wa.me/$phoneNumber');
      html.window.open(whatsappUri.toString(), '_blank');
    }
  }
