import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/data/models/PointerTypeModel.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/cubit/pointer_types_cubit.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/AssetsDialogInput.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/PointerTypesTableWidget.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointerTypesView extends StatefulWidget {
  PointerTypesView({super.key});

  @override
  State<PointerTypesView> createState() => _PointerTypesViewState();
}

class _PointerTypesViewState extends State<PointerTypesView> {
  PointerTypeCubit pointersTypesCubit = PointerTypeCubit();

  @override
  void initState() {
    super.initState();
    pointersTypesCubit.fetchPointerTypes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PointerTypeCubit, PointerTypesState>(
      bloc: pointersTypesCubit,
      builder: (context, state) {
        if (state is PointerTypesLoading) {
          return Center(child: CircularProgressIndicator());
        }
        else if (state is PointerTypesLoaded) {
          return Scaffold(
            body: Container(
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/back.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.2
                ),
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
                        child: Text(
                          "مؤشرات التقييم",
                          style: Constants.theme.textTheme.titleLarge?.copyWith(
                            color: Colors.black,
                            fontSize: 27
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _addDialog ,
                        icon: Icon(CupertinoIcons.add_circled_solid)
                      )
                    ],
                  ),
                  Expanded(
                    child: PointerTypesTableWidget(
                      edit: (pointerType) {
                        _editDialog(pointerType);
                      } ,
                      delete: (pointerType) {
                        _deleteDialog(pointerType);
                      } ,
                      allPointerType: state.pointerTypelist
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        else if (state is PointerTypesError) {
          return Center(
            child: TextWidget(
              text: state.message
            )
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  _addDialog(){
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AssetsDialogInput(
          isInput: true,
          headerText: "اضافة مؤشر تقييم",
          imagePath: 'assets/images/clinic logo.jpg',
          onCancelPressed: () {
            Navigator.of(dialogContext).pop();
          },
          onOkPressed: (pointerType) => _addPointerType(pointerType , dialogContext),
        );
      },
    );
  }

  _editDialog(PointerTypeModel mainpointerType){
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AssetsDialogInput(
          isInput: true,
          headerText: "تعديل مؤشر تقييم",
          imagePath: 'assets/images/clinic logo.jpg',
          okButtoneText: "تعديل",
          pointerType: mainpointerType,
          onCancelPressed: () {
            Navigator.of(dialogContext).pop();
          },
          onOkPressed: (pointerType) {
            pointerType.id = mainpointerType.id ;
            _editPointerType(pointerType, dialogContext);
          },
        );
      },
    );
  }

  _deleteDialog(PointerTypeModel pointerType){
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AssetsDialogInput(
          isInput: false,
          headerText: "حذف المؤشر",
          imagePath: 'assets/images/clinic logo.jpg',
          okButtoneText: "حذف",
          pointerType: pointerType,
          onCancelPressed: () {
            Navigator.of(dialogContext).pop();
          },
          onOkPressed: (pointerTypee) {
            print('-----------) ${pointerType.id}');
            _deletePointerType(pointerType, dialogContext);
          },
        );
      },
    );
  }

  _addPointerType(PointerTypeModel pointerType , BuildContext dialogContext){
    if(pointerType.desc.toString().replaceAll(" ", "") == "" || pointerType.name.toString().replaceAll(" ", "") == ""){
      SnackBarService.showErrorMessage("لا يجب ان يكون احدى المدخلات فارغ");
    }else{
      print('${pointerType.desc} || ${pointerType.name}');
      Navigator.of(dialogContext).pop();
      pointersTypesCubit.addPointerType(pointerType);
      SnackBarService.showSuccessMessage("تم الاضافه بنجاح");
    }
  }

  _editPointerType(PointerTypeModel pointerType , BuildContext dialogContext){
    if(pointerType.desc.toString().replaceAll(" ", "") == "" && pointerType.name.toString().replaceAll(" ", "") == ""){
      SnackBarService.showErrorMessage("لا يجب ان يكون احدى المدخلات فارغ");
    }else{
      print('${pointerType.id} || ${pointerType.desc} || ${pointerType.name}');
      Navigator.of(dialogContext).pop();
      pointersTypesCubit.updatePointerType(pointerType);
      SnackBarService.showSuccessMessage("تم التعديل بنجاح");
    }
  }

  _deletePointerType(PointerTypeModel pointerType , BuildContext dialogContext){
    Navigator.of(dialogContext).pop();
    print('===========) ${int.parse(pointerType.id.toString())}');
    pointersTypesCubit.deletePointerType(int.parse(pointerType.id.toString()));
    SnackBarService.showSuccessMessage("تم الحذف بنجاح");
  }
}
