import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/config/constants.dart';
import '../../../../../../../domain/entities/pointerModel.dart';
import '../../manager/cubit.dart';
import '../manager/dialog_cubit.dart';
import '../manager/dialog_state.dart';


class DialogDeletePointer extends StatefulWidget {
  final Pointers? pointerServices;
  final AllPointersCubit allPointerCubit;
  const DialogDeletePointer({
    Key? key,
    this.pointerServices,
    required this.allPointerCubit,
  }) : super(key: key);

  @override
  State<DialogDeletePointer> createState() => _DialogDeletePointerState();
}

class _DialogDeletePointerState extends State<DialogDeletePointer> {
  late UpdatePointerCubit updatePointerCubit;

  @override
  void initState() {
    super.initState();
    updatePointerCubit = UpdatePointerCubit();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pointerServices == null) {
      return const Text("No pointer service provided");
    }

    return BlocBuilder<UpdatePointerCubit, UpdatePointerStates>(
      bloc: updatePointerCubit,
      builder: (context, state) {
        return IconButton(
          icon: Icon(Icons.delete,color: Colors.grey.shade200,),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    backgroundColor: Constants.theme.primaryColor.withOpacity(0.8),

                    title: Text("حذف المؤشر",style:Constants.theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white
                    ),),
                    content: Text("هل أنت متأكد أنك تريد حذف هذا المؤشر ",style:Constants.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white
                    ),),
                    actions: [
                      TextButton(
                        onPressed: () {
                          updatePointerCubit.
                          deletePointer(
                            widget.pointerServices!.id!,
                          ).then((_) {
                            widget.allPointerCubit.getAllPointers();
                            Navigator.of(context).pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.5,
                            ),
                          ),
                          child: Text(
                            "موافق",
                            style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                          ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}


