import 'package:experts_app/core/config/constants.dart';
import 'package:flutter/material.dart';
import '../widget/LineChartAdvice.dart';

class AdviceReportView extends StatefulWidget {
  const AdviceReportView({super.key});

  @override
  State<AdviceReportView> createState() => _AdviceReportViewState();
}

class _AdviceReportViewState extends State<AdviceReportView> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("توصيات الحالات",style: Constants.theme.textTheme.titleLarge,),
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
            opacity: 1.0
          )
        ),
        child: LineChartsAdvice(),
      ),
    );
  }
}
