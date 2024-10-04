import 'package:dio/dio.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';
import 'package:experts_app/features/homeAdvisor/recycle_pin/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/config/constants.dart';
import '../../../../core/config/cash_helper.dart';
import '../manager/cubit.dart';


class DialogDeletePatientCycleWithAdmin extends StatefulWidget {
  final Pationts? patient;
  final AllPatientRecycleCubit allPatientCubit;
  const DialogDeletePatientCycleWithAdmin({
    Key? key,
    this.patient,
    required this.allPatientCubit,
  }) : super(key: key);

  @override
  State<DialogDeletePatientCycleWithAdmin> createState() => _DialogDeletePatientCycleWithAdminState();
}

class _DialogDeletePatientCycleWithAdminState extends State<DialogDeletePatientCycleWithAdmin> {
  late AllPatientRecycleCubit updatePatientCubit;

  @override
  void initState() {
    super.initState();
    updatePatientCubit = AllPatientRecycleCubit();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.patient == null) {
      return const Text("No consultation service provided");
    }

    return BlocBuilder<AllPatientRecycleCubit, AllPatientRecycleStates>(
      bloc: updatePatientCubit,
      builder: (context, state) {
        return IconButton(
          icon: Icon(CupertinoIcons.arrow_up_arrow_down_circle,color: Colors.white,),
          // onPressed: ()async {
          //  await updatePatient(widget.patient!.id!);
          //  await widget.allPatientCubit.getAllPatientRecycle(1); // Call refresh method
          //
          // },
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("استعادة الحالة",style:Constants.theme.textTheme.titleLarge?.copyWith(
                      color: Colors.black
                  ),),
                  content: Text("هل أنت متأكد أنك تريد استعادة هذه الحالة ",style:Constants.theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black
                  ),),
                  actions: [
                    TextButton(
                      onPressed: () async{
                        await updatePatient(widget.patient!.id!);
                        await widget.allPatientCubit.getAllPatientRecycleWithAdmin(1);
                        Navigator.of(context).pop();

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Constants.theme.primaryColor,
                            width: 2.5,
                          ),
                        ),
                        child: Text(
                          "موافق",
                          style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                        ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );

  }

}
Future<Response> updatePatient(int id) async{
  final Dio dio = Dio();
  return await dio.patch(
      "${Constants.baseUrl}/api/pationt/update",
      options: Options(
        headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        },
      ),

      data: {
        "id":id,
        "is_deleted":0
      }
  );


}



