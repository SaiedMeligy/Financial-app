import 'package:experts_app/features/homeAdmin/PointerTypes/data/models/PointerTypeModel.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/ButtonWidget.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextFaildWidget.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class AssetsDialogInput extends StatefulWidget {
  String headerText ;
  String? okButtoneText ;
  String? cancelButtoneText ;
  String imagePath ;
  bool isInput ;
  PointerTypeModel? pointerType = PointerTypeModel();
  Function(PointerTypeModel pointerType) onOkPressed ;
  Function() onCancelPressed ;

  AssetsDialogInput({
    super.key ,
    required this.headerText,
    required this.imagePath ,
    required this.onCancelPressed ,
    required this.onOkPressed ,
    required this.isInput ,
    this.okButtoneText ,
    this.cancelButtoneText ,
    this.pointerType ,
  });

  @override
  State<AssetsDialogInput> createState() => _AssetsDialogInputState();
}

class _AssetsDialogInputState extends State<AssetsDialogInput> {
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  void initState() {
    if(widget.pointerType != null){
      name = TextEditingController(text: widget.pointerType!.name);
      desc = TextEditingController(text: widget.pointerType!.desc);
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
              controller: desc,
              hintText: 'الوصف',
            ),
            SizedBox(height: 5,),
            TextFieldWidget(
              controller: name,
              hintText: 'المؤشر',
            )
          ] : [],
        ),
        actions: [
          ButtonWidget(
            text: widget.okButtoneText ?? "اضف",
            onPressed: _onButtonOkPressed
          ),
          ButtonWidget(
            text: widget.cancelButtoneText??"الغاء",
            onPressed: widget.onCancelPressed
          )
        ],
        entryAnimation: EntryAnimation.topLeft,
        actionsAlignment: MainAxisAlignment.start ,
      ),
    );
  }

  _onButtonOkPressed() {
    widget.onOkPressed(PointerTypeModel(name: name.value.text, desc: desc.value.text)) ;
  }
}
