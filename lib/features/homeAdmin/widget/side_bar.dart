import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';

class SideBar extends StatefulWidget {
  final String title;
  const SideBar({super.key,required this.title});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
