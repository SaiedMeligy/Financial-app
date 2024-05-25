import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/config/constants.dart';
import '../../../../../../../domain/entities/AdviceMode.dart';
import '../../manager/cubit.dart';
import '../manager/dialog_cubit.dart';
import '../manager/dialog_state.dart';


class DialogDeleteAdvice extends StatefulWidget {
  final Advices? advicesServices;
  final AllAdvicesCubit allAdviceCubit;
  const DialogDeleteAdvice({
    Key? key,
    this.advicesServices,
    required this.allAdviceCubit,
  }) : super(key: key);

  @override
  State<DialogDeleteAdvice> createState() => _DialogDeleteAdviceState();
}

class _DialogDeleteAdviceState extends State<DialogDeleteAdvice> {
  late UpdateAdviceCubit updateAdviceCubit;

  @override
  void initState() {
    super.initState();
    updateAdviceCubit = UpdateAdviceCubit();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.advicesServices == null) {
      return const Text("No consultation service provided");
    }

    return BlocBuilder<UpdateAdviceCubit, UpdateAdviceStates>(
      bloc: updateAdviceCubit,
      builder: (context, state) {
        return IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("حذف التوصية",style:Constants.theme.textTheme.titleLarge?.copyWith(
                    color: Colors.black
                  ),),
                  content: Text("هل أنت متأكد أنك تريد حذف هذه التوصية ",style:Constants.theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black
                  ),),
                  actions: [
                    TextButton(
                      onPressed: () {
                        updateAdviceCubit.
                        deleteAdvice(
                          widget.advicesServices!.id!,
                        ).then((_) {
                          widget.allAdviceCubit.getAllAdvices();
                          Navigator.of(context).pop();
                        });
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


