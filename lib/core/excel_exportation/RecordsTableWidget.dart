import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:convert' as convert ;
import 'package:excel/excel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../widget/border_rounded_button.dart';


class RecordsTableWidget extends StatefulWidget {
  RecordsTableWidget({super.key});

  @override
  State<RecordsTableWidget> createState() => _RecordsTableWidgetState();
}

class _RecordsTableWidgetState extends State<RecordsTableWidget> {
  int totalCount = 0 ;
  List<dynamic> data = [] ;
  List<dynamic> header = [] ;
  List<dynamic> header2 = [] ;
  @override
  void initState() {
    getAllData(1 , 1).then((value) {
      totalCount = value["totalCount"] ;
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.sizeOf(context).height ,
        width: MediaQuery.sizeOf(context).width ,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextWidget(
            //   text: "عدد الحالات $totalCount" ,
            //   fontFamily: "ElMessiri",
            //   fontSize: 20 ,
            //   color: Colors.black,
            //   textType: Typewriter(),
            // ) ,
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BorderRoundedButton(
                  title: "excel",
                  onPressed: () async {
                    header.clear();
                    header2.clear();
                    data.clear();
                    int patiCount = 50 ;
                    EasyLoading.show();
                    for (int i = 0 ; i < (totalCount/50).ceil() ; i++) {
                      print('page number ${i+1} is started');
                      var value = await getAllData(patiCount, i);
                      header.add(value["header"]);
                      header2.add(value["header2"]);
                      List<dynamic> d = value["data"] ;
                      data.add(d);
                      print('page number ${i+1} is finished');
                    }
                    saveListToExcel(header[0],header2[0] , data , patiCount);
                    EasyLoading.dismiss();
                    EasyLoading.showSuccess('Done');
                  },
                ),

                // ButtonWidget(
                //   onPressed: () async {
                //     header.clear();
                //     header2.clear();
                //     data.clear();
                //     int patiCount = 50 ;
                //     EasyLoading.show();
                //     for (int i = 0 ; i < (totalCount/50).ceil() ; i++) {
                //       print('page number ${i+1} is started');
                //       var value = await getAllData(patiCount, i);
                //       header.add(value["header"]);
                //       header2.add(value["header2"]);
                //       List<dynamic> d = value["data"] ;
                //       data.add(d);
                //       print('page number ${i+1} is finished');
                //     }
                //     saveListToExcel(header[0],header2[0] , data , patiCount);
                //     EasyLoading.dismiss();
                //     EasyLoading.showSuccess('Done');
                //   },
                //   fontColor: Colors.white ,
                //   text: "excel",
                //   fontSize: 20,
                //   fontFamily: "ElMessiri",
                //   buttonColor: Colors.black,
                //   height: 30,
                //   width: 100 ,
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                // ),
                SizedBox(width: 10,),
                SizedBox(
                  width: 150,
                  child: BorderRoundedButton(
                    title: "full backup",
                    onPressed: () {
                      getDatabaseBackup();


                    },
                  ),
                ),
                // ButtonWidget(
                //   onPressed: (){
                //     getDatabaseBackup();
                //   },
                //   fontColor: Colors.white ,
                //   text: "Full Backup",
                //   fontSize: 20,
                //   fontFamily: "ElMessiri",
                //   buttonColor: Colors.black,
                //   height: 30,
                //   width: 150 ,
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<Map<dynamic,dynamic>> getAllData(int numberOfPatint , int page) async {
    try {
      var data = await Dio().post(
        // "http://127.0.0.1:8000/api/PointersEvaluation/allPatient" ,
        "https://financialclinic.site/financial_clinic_apis/public/api/PointersEvaluation/allPatient" ,
        data: FormData.fromMap({
          'numberOfPatint': numberOfPatint,
          'page': page
        })
      );

      return await data.data ;
    } catch (e) {
      return {};
    }
  }

  Future<Map<dynamic,dynamic>> getDatabaseBackup() async {
    try {
      EasyLoading.show();
      var data = await Dio().post(
        "https://financialclinic.site/financial_clinic_apis/public/api/PointersEvaluation/downloadDatabaseBackup" ,
      );
      saveTextFile((await data.data).toString(), "backup${DateTime.now()}.sql");
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Done');
      return await data.data ;
    } catch (e) {
      return {};
    }
  }

  void saveListToExcel(List<dynamic> header , List<dynamic> header2 , List<dynamic> allData , int patiCount) {
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];
    List<TextCellValue> headers = [];
    header.forEach((element) {
      headers.add(TextCellValue(element["title"].toString()));
      for(int i = 1 ; i < element["number"] ; i++){
        headers.add(TextCellValue(""));
      }
    });
    sheet.appendRow(headers);

    List<TextCellValue> headers2 = [];
    header2.forEach((element) {
      headers2.add(TextCellValue(element.toString()));
    });
    sheet.appendRow(headers2);

    int counter = 1 ;
    for(int d = 0 ; d < allData.length ; d++){
      for(int mainIndex = 0 ; mainIndex < patiCount ; mainIndex++){
        List<TextCellValue> rowData = [] ;
        try{
          for(int i = 0 ; i < allData[d].length ; i++){
            rowData.add(TextCellValue(allData[d][i][mainIndex].toString()));
          }
        }catch(e){

        }
        print('===) $counter');
        counter++;
        sheet.appendRow(rowData);
      }
    }
    var fileBytes = excel.encode();
    if (fileBytes != null) {
      final blob = html.Blob([Uint8List.fromList(fileBytes)]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "session${DateTime.now()}.xlsx")
        ..click();
      html.Url.revokeObjectUrl(url);
      print('✅ تم حفظ الملف بنجاح!');
    } else {
      print('❌ حدث خطأ أثناء إنشاء الملف!');
    }
  }

  void saveTextFile(String content, String fileName) {
    final bytes = Uint8List.fromList(convert.utf8.encode(content));
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}