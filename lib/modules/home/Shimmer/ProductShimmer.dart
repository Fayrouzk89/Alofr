import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
class SetMenuShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left:10),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 200,
          width: 150,
          margin:
          EdgeInsets.only(right: 10, bottom: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),

          ),
          child: Shimmer(
            duration: Duration(seconds: 1),
            interval: Duration(seconds: 1),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 110,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(10)),
                    color: Colors.grey[300]),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 15, width: 130, color: Colors.grey[300]),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 10,
                                  width: 50,
                                  color: Colors.grey[300]),
                            ]),
                      ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
