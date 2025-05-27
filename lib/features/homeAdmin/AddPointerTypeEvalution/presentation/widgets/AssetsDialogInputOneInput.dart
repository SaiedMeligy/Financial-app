import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/SessionPointersEvaluations.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/data/models/PointerTypeModel.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/ButtonWidget.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextFaildWidget.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import '../../data/models/AllSessionPointersTypeEvaluation.dart';

class AssetsDialogInputOneInput extends StatefulWidget {
  String headerText ;
  String? okButtoneText ;
  String? cancelButtoneText ;
  String imagePath ;
  bool isInput ;
  late SessionPointersEvaluations? sessionPointersEvaluations = SessionPointersEvaluations() ;
  Function(SessionPointersEvaluations sessionPointersEvaluations) onOkPressed ;
  Function() onCancelPressed ;

  AssetsDialogInputOneInput({
    super.key ,
    required this.headerText,
    required this.imagePath ,
    required this.onCancelPressed ,
    required this.onOkPressed ,
    required this.isInput ,
    this.sessionPointersEvaluations ,
    this.okButtoneText ,
    this.cancelButtoneText ,
  });

  @override
  State<AssetsDialogInputOneInput> createState() => _AssetsDialogInputOneInputState();
}

class _AssetsDialogInputOneInputState extends State<AssetsDialogInputOneInput> {
  TextEditingController evalutionController = TextEditingController();

  @override
  void initState() {
    if(widget.sessionPointersEvaluations != null){
      evalutionController = TextEditingController(text: widget.sessionPointersEvaluations!.evaluation.toString());
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GiffyDialog(
        backgroundColor: Colors.white,
        giffy: Image.asset(
          widget.imagePath,
          fit: BoxFit.cover,
          scale: 5,
        ),
        title: TextWidget(
          text: widget.headerText ,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.isInput ? [
            TextFieldWidget(
              controller: evalutionController,
              hintText: "التقييم",
            ),
          ] : [],
        ),
        actions: [
          ButtonWidget(
            text: widget.okButtoneText ?? "اضف",
            onPressed: _onButtonOkPressed
          ),
          ButtonWidget(
            text: widget.cancelButtoneText ?? "الغاء",
            onPressed: widget.onCancelPressed
          )
        ],
        entryAnimation: EntryAnimation.topLeft,
        actionsAlignment: MainAxisAlignment.start ,
      ),
    );
  }

  _onButtonOkPressed() {
    widget.onOkPressed(
      SessionPointersEvaluations(
        id: widget.sessionPointersEvaluations!.id ,
        evaluation: double.parse(evalutionController.value.text) ,
      )
    );
  }
}
