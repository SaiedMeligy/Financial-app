import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2.2 + 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Shimmer(
                  duration: Duration(seconds: 2),
                  color: Colors.grey,
                  enabled: true ,
                  child: Container(
                    height: 60,
                    width: 200,
                    color: Colors.grey[300],
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Shimmer(
                  duration: Duration(seconds: 2),
                  color: Colors.grey,
                  child: Expanded(
                    child: Container(
                      height: 60,
                      width: 200,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Shimmer(
                  duration: Duration(seconds: 2),
                  color: Colors.grey,
                  enabled: true ,
                  child: Expanded(
                    child: Container(
                      height: 200,
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
