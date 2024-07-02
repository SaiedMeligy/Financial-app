import 'package:flutter/material.dart';

class AddStatesFromOtherResoursce extends StatefulWidget {
  const AddStatesFromOtherResoursce({super.key});

  @override
  State<AddStatesFromOtherResoursce> createState() => _AddStatesFromOtherResoursceState();
}

class _AddStatesFromOtherResoursceState extends State<AddStatesFromOtherResoursce> {
  bool uploaded = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: uploaded ? Container(

        ) : Table(
          children: [

          ],
        ),
      ),
    );
  }
}
