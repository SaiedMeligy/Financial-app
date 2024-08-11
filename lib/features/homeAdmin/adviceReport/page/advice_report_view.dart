import 'package:experts_app/core/config/constants.dart';
import 'package:flutter/cupertino.dart';
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
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
            opacity: 0.2
          )
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color:Colors.black,
                        width: 2,
                      )
                  ),
                  child: Text("توصيات الحالات", style: Constants.theme.textTheme
                      .titleLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 27
                  ),),
                ),
              ],
            ),

            Expanded(child: LineChartsAdvice()),
          ],
        ),
      ),
    );
  }
}
