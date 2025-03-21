// pw.Table(
//     border: pw.TableBorder.all(
//       color: PdfColors.black,
//       width: 1,
//     ),
//     children: [
//       pw.TableRow(
//         children: [
//           pw.Center(child:
//           pw.Padding(
//             padding: const pw.EdgeInsets.all(5.0),
//             child: pw.Text(
//               "المؤشرات",
//               style: pw.TextStyle(font: ttf, fontSize: 12),
//               textDirection: pw.TextDirection.rtl,
//             ),
//           ),
//           ),
//         ],
//       ),
//     ]
// ),
// pw.Table(
//   border: pw.TableBorder.all(
//     color: PdfColors.black,
//     width: 1,
//   ),
//   children: [
//     pw.TableRow(
//       children: [
//         pw.Padding(
//           padding: const pw.EdgeInsets.all(8.0),
//           child: pw.Text(
//             "السيناريو الثالث",
//             style: pw.TextStyle(font: ttf, fontSize: 12),
//             textDirection: pw.TextDirection.rtl,
//           ),
//         ),
//         pw.Padding(
//           padding: const pw.EdgeInsets.all(8.0),
//           child: pw.Text(
//             "السيناريو الثانى",
//             style: pw.TextStyle(font: ttf, fontSize: 12),
//             textDirection: pw.TextDirection.rtl,
//           ),
//         ),
//         pw.Padding(
//           padding: const pw.EdgeInsets.all(8.0),
//           child: pw.Text(
//             "السيناريو الاول",
//             style: pw.TextStyle(font: ttf, fontSize: 12),
//             textDirection: pw.TextDirection.rtl,
//           ),
//         ),
//
//
//       ],
//     ),
//     // Add more rows as needed
//     pw.TableRow(
//       children: [
//         pw.Padding(
//           padding: const pw.EdgeInsets.all(5.0),
//           child: pw.Container(
//             height: 260,
//             child: pw.Column(
//               children: [
//                 for (var index3 = 0; index3 < pointers3Temp.length; index3++)
//                   pw.Container(
//                     margin: const pw.EdgeInsets.only(bottom: 5.0),
//                     child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Column(
//                           mainAxisAlignment: pw.MainAxisAlignment.start,
//                           children: [
//                             pw.Table(
//                               // border: pw.TableBorder.all(color: PdfColors.black),
//                               children: [
//                                 for (var index3 = 0; index3 < pointers3Temp.length; index3++)
//                                   ...[
//                                     for (var pointer in pointers3Temp[index3]["pationt_pointers"] ?? [])
//                                       pw.TableRow(
//                                         children: [
//                                           pw.Padding(
//                                             padding: const pw.EdgeInsets.all(2.0),
//                                             child: pw.Text(
//                                               pointer["text"],
//                                               style: pw.TextStyle(
//                                                 font: ttf,
//                                                 fontSize: 8,
//                                                 color: PdfColors.black,
//                                               ),
//                                               textDirection: pw.TextDirection.rtl,
//                                             ),
//                                           ),
//                                         ],),],
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],),
//                   ),],),),),
//         pw.Padding(
//           padding: const pw.EdgeInsets.all(5.0),
//           child: pw.Container(
//             height: 260,
//             child: pw.Column(
//               children: [
//                 for (var index2 = 0; index2 < pointers2Temp.length; index2++)
//                   pw.Container(
//                     margin: const pw.EdgeInsets.only(bottom: 5.0),
//                     child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Column(
//                           mainAxisAlignment: pw.MainAxisAlignment.start,
//                           children: [
//                             pw.Table(
//                               // border: pw.TableBorder.all(color: PdfColors.black),
//                               children: [
//                                 for (var index2 = 0; index2 < pointers2Temp.length; index2++)
//                                   ...[
//                                     for (var pointer in pointers2Temp[index2]["pationt_pointers"] ?? [])
//                                       pw.TableRow(
//                                         children: [
//                                           pw.Padding(
//                                             padding: const pw.EdgeInsets.all(2.0),
//                                             child: pw.Text(
//                                               pointer["text"],
//                                               style: pw.TextStyle(
//                                                 font: ttf,
//                                                 fontSize: 8,
//                                                 color: PdfColors.black,
//                                               ),
//                                               textDirection: pw.TextDirection.rtl,
//                                             ),
//                                           ),
//                                         ],),],
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],),
//                   ),],),),),
//         pw.Padding(
//           padding: const pw.EdgeInsets.all(5.0),
//           child: pw.Container(
//             height: 260,
//             child: pw.Column(
//               children: [
//                 for (var index1 = 0; index1 < pointers1Temp.length; index1++)
//                   pw.Container(
//                     margin: const pw.EdgeInsets.only(bottom: 5.0),
//                     child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Column(
//                           mainAxisAlignment: pw.MainAxisAlignment.start,
//                           children: [
//                             pw.Table(
//                               // border: pw.TableBorder.all(color: PdfColors.black),
//                               children: [
//                                 for (var index1 = 0; index1 < pointers1Temp.length; index1++)
//                                   ...[
//                                     for (var pointer in pointers1Temp[index1]["pationt_pointers"] ?? [])
//                                       pw.TableRow(
//                                         children: [
//                                           pw.Padding(
//                                             padding: const pw.EdgeInsets.all(2.0),
//                                             child: pw.Text(
//                                               pointer["text"],
//                                               style: pw.TextStyle(
//                                                 font: ttf,
//                                                 fontSize: 8,
//                                                 color: PdfColors.black,
//                                               ),
//                                               textDirection: pw.TextDirection.rtl,
//                                             ),
//                                           ),
//                                         ],),],
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],),
//                   ),],),),),
//
//
//
//       ],
//     ),
//
//   ],
// ),
//todo

// Container(
//   height: Constants.mediaQuery.height*0.4,
//   decoration: BoxDecoration(
//     border: Border.all(
//       width: 2,
//       color: Colors.black,
//     ),
//   ),
//   child: Column(
//     children: [
//
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//
//           Spacer(),
//           Text(
//             "المؤشرات",
//             textAlign: TextAlign.center,
//             style: Constants.theme.textTheme.titleLarge?.copyWith(
//               color: Colors.black,
//             ),
//           ),
//           Spacer(),
//           IconButton(
//             onPressed: () {
//               selectedPointers1.clear();
//               selectedPointers2.clear();
//               selectedPointers3.clear();
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     backgroundColor: Colors.black,
//                     title: Container(
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: Constants.theme.primaryColor,
//                           width: 2.5,
//                         ),
//                       ),
//                       child: Text(
//                         "اختر من المؤشرات",
//                         style: Constants.theme.textTheme.titleLarge,
//                       ),
//                     ),
//                     content: SizedBox(
//                       height: Constants.mediaQuery.height * 0.6,
//                       width: Constants.mediaQuery.width * 0.45,
//                       child: TabItemWidget(
//                         item1: "السيناريو الاول",
//                         item2: "السيناريو التاني",
//                         item3: "السيناريو التالت",
//                         firstWidget: CheckBoxQuestion(
//                           items: pointers1,
//                           previous: selectedPointers1.isNotEmpty ? selectedPointers1[0] : [],
//                           onChanged: (value) {
//                             setState(() {
//                               if (selectedPointers1.isEmpty) {
//                                 selectedPointers1.add(value!);
//                               } else {
//                                 selectedPointers1[0] = value!;
//                               }
//                             });
//                           },
//                         ),
//                         secondWidget: CheckBoxQuestion(
//                           previous: selectedPointers2.isNotEmpty ? selectedPointers2[0] : [],
//                           items: pointers2,
//                           onChanged: (value) {
//                             setState(() {
//                               if (selectedPointers2.isEmpty) {
//                                 selectedPointers2.add(value!);
//                               } else {
//                                 selectedPointers2[0] = value!;
//                               }
//                             });
//                           },
//                         ),
//                         thirdWidget: CheckBoxQuestion(
//                           previous: selectedPointers3.isNotEmpty ? selectedPointers3[0] : [],
//                           items: pointers3,
//                           onChanged: (value) {
//                             setState(() {
//                               if (selectedPointers3.isEmpty) {
//                                 selectedPointers3.add(value!);
//                               } else {
//                                 selectedPointers3[0] = value!;
//                               }
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () async {
//                           List<int> selectedPointersIds = [];
//                           if (selectedPointers1.isNotEmpty) {
//                             selectedPointersIds.addAll(selectedPointers1.expand((x) => x));
//                           }
//                           if (selectedPointers2.isNotEmpty) {
//                             selectedPointersIds.addAll(selectedPointers2.expand((x) => x));
//                           }
//                           if (selectedPointers3.isNotEmpty) {
//                             selectedPointersIds.addAll(selectedPointers3.expand((x) => x));
//                           }
//
//                           if (selectedPointersIds.isNotEmpty) {
//                             for (var pointerId in selectedPointersIds) {
//                               try {
//                                 await addPointers(pointerId, patient["id"]);
//                               } catch (e) {
//                                 print('Error adding pointerId $pointerId: $e');
//                               }
//                             }
//                             addSessionCubit.setRefreshAdvicor(widget.pationt_data.nationalId);
//                           }
//                           Navigator.of(context).pop();
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(
//                               color: Constants.theme.primaryColor,
//                               width: 2.5,
//                             ),
//                           ),
//                           child: Text(
//                             "موافق",
//                             style: Constants.theme.textTheme.bodyMedium,
//                           ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             icon: Icon(Icons.add_circle_rounded),
//           ),
//
//         ],
//       ).setVerticalPadding(context,enableMediaQuery: false, 3),
//       Expanded(
//         child: TabItemWidget(
//           item1: "السيناريوالأول(الحالات المتوازنة نسبيا)",
//           item2: "السيناريوالثاني(للحالات الغير متوازنة في الصرف)",
//           item3: "السيناريوالثالث(للحالات المتعثرة ماليا)",
//           firstWidget: Container(
//             color: Constants.theme.primaryColor.withOpacity(0.4),
//             child: ListView.builder(
//               itemCount: pointers1Temp.length,
//               itemBuilder: (context, index) {
//                 var pationtPointers = pointers1Temp[index]["pationt_pointers"] ?? [];
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     for (var pointer in pationtPointers)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               pointer["text"],
//                               style: TextStyle(
//                                 fontSize: isMobile?14:20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           IconButton(onPressed: (){
//                             deletePointers(patient["id"], pointer["id"]);
//                             addSessionCubit.setRefreshAdvicor(widget.pationt_data.nationalId);
//                           }, icon: Icon(Icons.delete))
//                         ],
//                       ),
//                   ],
//                 ).setHorizontalPadding(context,enableMediaQuery: false,10 );
//               },
//             ),
//           ),
//           secondWidget: Container(
//             color: Constants.theme.primaryColor.withOpacity(0.4),
//             child: ListView.builder(
//               itemCount: pointers2Temp.length,
//               itemBuilder: (context, index) {
//                 var pationtPointers = pointers2Temp[index]["pationt_pointers"] ?? [];
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     for (var pointer in pationtPointers)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//
//                           Expanded(
//                             child: Text(
//                               pointer["text"],
//                               style: TextStyle(
//                                 fontSize: isMobile?14:20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           IconButton(onPressed: (){
//                             deletePointers(patient["id"], pointer["id"]);
//                             addSessionCubit.setRefreshAdvicor(widget.pationt_data.nationalId);
//
//
//                           }, icon: Icon(Icons.delete))
//                         ],
//                       ),
//                   ],
//                 ).setHorizontalPadding(context,enableMediaQuery: false,10 );
//               },
//             ),
//           ),
//           thirdWidget: Container(
//             color: Constants.theme.primaryColor.withOpacity(0.4),
//             child: ListView.builder(
//               itemCount: pointers3Temp.length,
//               itemBuilder: (context, index) {
//                 var pationtPointers = pointers3Temp[index]["pationt_pointers"] ?? [];
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     for (var pointer in pationtPointers)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//
//                           Expanded(
//                             child: Text(
//                               pointer["text"],
//                               style: TextStyle(
//                                 fontSize: isMobile?14:20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           IconButton(onPressed: (){
//                             deletePointers(patient["id"], pointer["id"]);
//                             addSessionCubit.setRefreshAdvicor(widget.pationt_data.nationalId);
//                           }, icon: Icon(Icons.delete))
//                         ],
//                       ),
//
//                   ],
//                 ).setHorizontalPadding(context,enableMediaQuery: false,10 );
//               },
//             ),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),


// ----------------------------------------------------------


//todo admin
// pw.Table(
//     border: pw.TableBorder.all(
//       color: PdfColors.black,
//       width: 1,
//     ),
//     children: [
//       pw.TableRow(
//         children: [
//           pw.Center(child:
//           pw.Padding(
//             padding: const pw.EdgeInsets.all(5.0),
//             child: pw.Text(
//               "المؤشرات",
//               style: pw.TextStyle(font: ttf, fontSize: 12),
//               textDirection: pw.TextDirection.rtl,
//             ),
//           ),
//           ),
//         ],
//       ),
//     ]
// ),
// pw.Table(
//   border: pw.TableBorder.all(
//     color: PdfColors.black,
//     width: 1,
//   ),
//   children: [
//     pw.TableRow(
//       children: [
//         pw.Padding(
//           padding: const pw.EdgeInsets.all(8.0),
//           child: pw.Text(
//             "السيناريو الثالث",
//             style: pw.TextStyle(font: ttf, fontSize: 12),
//             textDirection: pw.TextDirection.rtl,
//           ),
//         ),
//         pw.Padding(
//           padding: const pw.EdgeInsets.all(8.0),
//           child: pw.Text(
//             "السيناريو الثانى",
//             style: pw.TextStyle(font: ttf, fontSize: 12),
//             textDirection: pw.TextDirection.rtl,
//           ),
//         ),
//         pw.Padding(
//           padding: const pw.EdgeInsets.all(8.0),
//           child: pw.Text(
//             "السيناريو الاول",
//             style: pw.TextStyle(font: ttf, fontSize: 12),
//             textDirection: pw.TextDirection.rtl,
//           ),
//         ),
//
//
//       ],
//     ),
//     // Add more rows as needed
//     pw.TableRow(
//       children: [
//         pw.Padding(
//           padding: const pw.EdgeInsets.all(5.0),
//           child: pw.Container(
//             height: 260,
//             child: pw.Column(
//               children: [
//                 for (var index3 = 0; index3 < pointers3Temp.length; index3++)
//                   pw.Container(
//                     margin: const pw.EdgeInsets.only(bottom: 5.0),
//                     child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Column(
//                           mainAxisAlignment: pw.MainAxisAlignment.start,
//                           children: [
//                             pw.Table(
//                               // border: pw.TableBorder.all(color: PdfColors.black),
//                               children: [
//                                 for (var index3 = 0; index3 < pointers3Temp.length; index3++)
//                                   ...[
//                                     for (var pointer in pointers3Temp[index3]["pationt_pointers"] ?? [])
//                                       pw.TableRow(
//                                         children: [
//                                           pw.Padding(
//                                             padding: const pw.EdgeInsets.all(2.0),
//                                             child: pw.Text(
//                                               pointer["text"],
//                                               style: pw.TextStyle(
//                                                 font: ttf,
//                                                 fontSize: 8,
//                                                 color: PdfColors.black,
//                                               ),
//                                               textDirection: pw.TextDirection.rtl,
//                                             ),
//                                           ),
//                                         ],),],
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],),
//                   ),],),),),
//         pw.Padding(
//           padding: const pw.EdgeInsets.all(5.0),
//           child: pw.Container(
//             height: 260,
//             child: pw.Column(
//               children: [
//                 for (var index2 = 0; index2 < pointers2Temp.length; index2++)
//                   pw.Container(
//                     margin: const pw.EdgeInsets.only(bottom: 5.0),
//                     child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Column(
//                           mainAxisAlignment: pw.MainAxisAlignment.start,
//                           children: [
//                             pw.Table(
//                               // border: pw.TableBorder.all(color: PdfColors.black),
//                               children: [
//                                 for (var index2 = 0; index2 < pointers2Temp.length; index2++)
//                                   ...[
//                                     for (var pointer in pointers2Temp[index2]["pationt_pointers"] ?? [])
//                                       pw.TableRow(
//                                         children: [
//                                           pw.Padding(
//                                             padding: const pw.EdgeInsets.all(2.0),
//                                             child: pw.Text(
//                                               pointer["text"],
//                                               style: pw.TextStyle(
//                                                 font: ttf,
//                                                 fontSize: 8,
//                                                 color: PdfColors.black,
//                                               ),
//                                               textDirection: pw.TextDirection.rtl,
//                                             ),
//                                           ),
//                                         ],),],
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],),
//                   ),],),),),
//         pw.Padding(
//           padding: const pw.EdgeInsets.all(5.0),
//           child: pw.Container(
//             height: 260,
//             child: pw.Column(
//               children: [
//                 for (var index1 = 0; index1 < pointers1Temp.length; index1++)
//                   pw.Container(
//                     margin: const pw.EdgeInsets.only(bottom: 5.0),
//                     child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Column(
//                           mainAxisAlignment: pw.MainAxisAlignment.start,
//                           children: [
//                             pw.Table(
//                               // border: pw.TableBorder.all(color: PdfColors.black),
//                               children: [
//                                 for (var index1 = 0; index1 < pointers1Temp.length; index1++)
//                                   ...[
//                                     for (var pointer in pointers1Temp[index1]["pationt_pointers"] ?? [])
//                                       pw.TableRow(
//                                         children: [
//                                           pw.Padding(
//                                             padding: const pw.EdgeInsets.all(2.0),
//                                             child: pw.Text(
//                                               pointer["text"],
//                                               style: pw.TextStyle(
//                                                 font: ttf,
//                                                 fontSize: 8,
//                                                 color: PdfColors.black,
//                                               ),
//                                               textDirection: pw.TextDirection.rtl,
//                                             ),
//                                           ),
//                                         ],),],
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],),
//                   ),],),),),
//
//
//
//       ],
//     ),
//
//   ],
// ),
//todo
// Container(
//   height: Constants.mediaQuery.height*0.4,
//   decoration: BoxDecoration(
//     border: Border.all(
//       width: 2,
//       color: Colors.black,
//     ),
//   ),
//   child: Column(
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//
//           Spacer(),
//           Text(
//             "المؤشرات",
//             textAlign: TextAlign.center,
//             style: Constants.theme.textTheme.titleLarge?.copyWith(
//               color: Colors.black,
//             ),
//           ),
//           Spacer(),
//   IconButton(
//     onPressed: () {
//       selectedPointers1.clear();
//       selectedPointers2.clear();
//       selectedPointers3.clear();
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//
//             backgroundColor: Colors.black,
//             title: Container(
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   color: Constants.theme.primaryColor,
//                   width: 2.5,
//                 ),
//               ),
//               child: Text(
//                 "اختر من المؤشرات",
//                 style: isMobile?Constants.theme.textTheme.bodyMedium:Constants.theme.textTheme.titleLarge,
//               ),
//             ),
//             content: SizedBox(
//               height: Constants.mediaQuery.height * 0.6,
//               width: Constants.mediaQuery.width * 0.45,
//               child: TabItemWidget(
//                 item1: "السيناريو الاول",
//                 item2: "السيناريو التاني",
//                 item3: "السيناريو التالت",
//                 firstWidget: CheckBoxQuestion(
//                   items: pointers1,
//                   previous: selectedPointers1.isNotEmpty ? selectedPointers1[0] : [],
//                   onChanged: (value) {
//                     setState(() {
//                       if (selectedPointers1.isEmpty) {
//                         selectedPointers1.add(value!);
//                       } else {
//                         selectedPointers1[0] = value!;
//                       }
//                     });
//                   },
//                 ),
//                 secondWidget: CheckBoxQuestion(
//                   previous: selectedPointers2.isNotEmpty ? selectedPointers2[0] : [],
//                   items: pointers2,
//                   onChanged: (value) {
//                     setState(() {
//                       if (selectedPointers2.isEmpty) {
//                         selectedPointers2.add(value!);
//                       } else {
//                         selectedPointers2[0] = value!;
//                       }
//                     });
//                   },
//                 ),
//                 thirdWidget: CheckBoxQuestion(
//                   previous: selectedPointers3.isNotEmpty ? selectedPointers3[0] : [],
//                   items: pointers3,
//                   onChanged: (value) {
//                     setState(() {
//                       if (selectedPointers3.isEmpty) {
//                         selectedPointers3.add(value!);
//                       } else {
//                         selectedPointers3[0] = value!;
//                       }
//                     });
//                   },
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () async {
//                   List<int> selectedPointersIds = [];
//                   if (selectedPointers1.isNotEmpty) {
//                     selectedPointersIds.addAll(selectedPointers1.expand((x) => x));
//                   }
//                   if (selectedPointers2.isNotEmpty) {
//                     selectedPointersIds.addAll(selectedPointers2.expand((x) => x));
//                   }
//                   if (selectedPointers3.isNotEmpty) {
//                     selectedPointersIds.addAll(selectedPointers3.expand((x) => x));
//                   }
//
//                   if (selectedPointersIds.isNotEmpty) {
//                     for (var pointerId in selectedPointersIds) {
//                       try {
//                         await addPointers(pointerId, patient["id"]);
//                       } catch (e) {
//                         print('Error adding pointerId $pointerId: $e');
//                       }
//                     }
//                     addSessionCubit.setRefresh(widget.pationt_data.nationalId,0);
//                   }
//                   Navigator.of(context).pop();
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: Constants.theme.primaryColor,
//                       width: 2.5,
//                     ),
//                   ),
//                   child: Text(
//                     "موافق",
//                     style: Constants.theme.textTheme.bodyMedium,
//                   ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                 ),
//               ),
//             ],
//           );
//         },
//       );
//     },
//     icon: Icon(Icons.add_circle_rounded),
//   ),
//         ],
//       ).setVerticalPadding(context,enableMediaQuery: false, 3),
//       Expanded(
//         child: TabItemWidget(
//           item1: "السيناريوالأول(الحالات المتوازنة نسبيا)",
//           item2: "السيناريوالثاني(للحالات الغير متوازنة في الصرف)",
//           item3: "السيناريوالثالث(للحالات المتعثرة ماليا)",
//           firstWidget: Container(
//             color: Constants.theme.primaryColor.withOpacity(0.4),
//             child: ListView.builder(
//               itemCount: pointers1Temp.length,
//               itemBuilder: (context, index) {
//                 var pationtPointers = pointers1Temp[index]["pationt_pointers"] ?? [];
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     for (var pointer in pationtPointers)
//                       Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         pointer["text"],
//                         style: TextStyle(
//                           fontSize: isMobile?14:20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                     IconButton(onPressed: (){
//                       deletePointers(patient["id"], pointer["id"]);
//                       addSessionCubit.setRefresh(widget.pationt_data.nationalId,0);
//                     }, icon: Icon(Icons.delete))
//                   ],
//                 ),
//                   ],
//                 ).setHorizontalPadding(context,enableMediaQuery: false,10 );
//               },
//             ),
//           ),
//           secondWidget: Container(
//             color: Constants.theme.primaryColor.withOpacity(0.4),
//             child: ListView.builder(
//               itemCount: pointers2Temp.length,
//               itemBuilder: (context, index) {
//                 var pationtPointers = pointers2Temp[index]["pationt_pointers"] ?? [];
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     for (var pointer in pationtPointers)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               pointer["text"],
//                               style: TextStyle(
//                                 fontSize: isMobile?14:20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           IconButton(onPressed: (){
//                             deletePointers(patient["id"], pointer["id"]);
//                             addSessionCubit.setRefresh(widget.pationt_data.nationalId,0);
//
//
//                           }, icon: Icon(Icons.delete))
//                         ],
//                       ),
//                   ],
//                 ).setHorizontalPadding(context,enableMediaQuery: false,10 );
//               },
//             ),
//           ),
//           thirdWidget: Container(
//             color: Constants.theme.primaryColor.withOpacity(0.4),
//             child: ListView.builder(
//               itemCount: pointers3Temp.length,
//               itemBuilder: (context, index) {
//                 var pationtPointers = pointers3Temp[index]["pationt_pointers"] ?? [];
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     for (var pointer in pationtPointers)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               pointer["text"],
//                               style: TextStyle(
//                                 fontSize: isMobile?14:20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           IconButton(onPressed: (){
//                             deletePointers(patient["id"], pointer["id"]);
//                             addSessionCubit.setRefresh(widget.pationt_data.nationalId,0);
//                           }, icon: Icon(Icons.delete))
//                         ],
//                       ),
//
//                   ],
//                 ).setHorizontalPadding(context,enableMediaQuery: false,10 );
//               },
//             ),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
