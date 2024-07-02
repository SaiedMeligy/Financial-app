import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/replace_advisor/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/replace_advisor/manager/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/config/constants.dart';
import '../../../addSession/widget/all_advisor_drop_down.dart';

class ReplaceAdvisorView extends StatefulWidget {
  final dynamic pationt_data;
  const ReplaceAdvisorView({super.key,required this.pationt_data});

  @override
  State<ReplaceAdvisorView> createState() => _ReplaceAdvisorViewState();
}

class _ReplaceAdvisorViewState extends State<ReplaceAdvisorView> {
  String? selected_advisor;
  var replacePatientWithAdmin = ReplacePatientWithAdminCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReplacePatientWithAdminCubit,ReplacePatientWithAdminStates>(
      bloc: replacePatientWithAdmin,
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Constants.theme.primaryColor,
            ),
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/back.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.8
                )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("تبديل الاستشاري",
                      style: Constants.theme.textTheme.titleLarge?.copyWith(
                          color: Colors.black
                      )),
                  SizedBox(width: 20),
                  DropdownButtonAdvisor(
                    onAdvisorSelected: (advicor_id) {
                      setState(() {
                        selected_advisor = advicor_id;
                        replacePatientWithAdmin.replacePatientWithAdmin(widget.pationt_data.id, int.parse(advicor_id)).then((response) {
                          if (response.data["status"]==true){
                            // SnackBarService.showSuccessMessage(response.data["message"]);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: AlertDialog(
                                        title: Text(
                                          "تم تعديل بيانات الحالة بنجاح",
                                          style: Constants.theme
                                              .textTheme.bodyMedium
                                              ?.copyWith(
                                              color: Colors.black
                                          ),),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(10),
                                                  border: Border.all(
                                                    color: Constants.theme
                                                        .primaryColor,
                                                    width: 2.5,
                                                  ),
                                                ),
                                                child: Text("اغلاق",
                                                  style: Constants.theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                      color: Colors.black
                                                  ),).setHorizontalPadding(
                                                    context,
                                                    enableMediaQuery: false,
                                                    20)
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                }
                            );

                          }
                        });
                      });
                    },
                  ),
                ],
              ).setVerticalPadding(context,enableMediaQuery: false, 20).setHorizontalPadding(context,enableMediaQuery: false, 20),
            ),
          ),
        );
      }
    );
  }
}
