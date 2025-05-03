import 'package:flutter/material.dart';

class TableCellWidget extends StatelessWidget {
  EdgeInsetsGeometry padding ;
  Widget child ;
  TableCellWidget({super.key , required this.padding , required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
