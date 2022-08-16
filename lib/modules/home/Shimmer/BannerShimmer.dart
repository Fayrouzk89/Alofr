import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
class BannerShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 10),
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Shimmer(
          duration: Duration(seconds: 2),
          child: Container(
            width: 250, height: 85,
            margin: EdgeInsets.only(right:10),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 5)],
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}

