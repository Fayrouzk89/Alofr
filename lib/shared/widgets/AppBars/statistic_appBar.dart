import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../globals.dart' as globals;
class StatisticAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double barHeight = 150.0;

  StatisticAppBar({Key? key, this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.greenColor,
      height: 150,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            color: ColorConstants.greenColor,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(top:33.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10,),

                  /*
                            new IconButton(
                              icon: new Icon(Icons.arrow_circle_left_outlined, size: 40),
                              onPressed: (){Get.back();},
                            ),

                             */
                  Container(
                    child: Image.asset(globals.getLogoImage(),
                        height:60, width: 120, fit: BoxFit.cover),
                  ),
                  Spacer(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: ()
                      {
                        Get.back();
                      },
                      child: Image.asset('images/back.png',
                          height:25, width: 25, fit: BoxFit.contain),
                    ),
                  ),


                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}


