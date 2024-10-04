import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PointsWidget extends StatelessWidget {
  String name ;
  Map<dynamic,dynamic> data ;

  PointsWidget({required this.name, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20) ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , topRight: Radius.circular(10))
            ),
            child: Text(
              name ,
              style: const TextStyle(
                fontSize: 15 ,
                fontWeight: FontWeight.bold ,
                color: Colors.white
              ),
            ),
          ),
          for(int i = 0 ; i < data.length ; i++)...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start ,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(width: 30,),
                      Container(
                        width: 10 ,
                        height: 10 ,
                        color: Colors.black38,
                      ),
                      SizedBox(width: 10,) ,
                      Text(
                        data.keys.toList()[i] ,
                        style: TextStyle(
                          fontSize: 20 ,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  data.values.toList()[i].toString() ,
                  style: TextStyle(
                      fontSize: 20 ,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,)
          ]
        ],
      ),
    );
  }
}
