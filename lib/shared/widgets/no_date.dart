import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/common.dart';



class NoData extends StatelessWidget {
  final String text;
  final String imagePath;
  NoData({
    required this.text,
    required this.imagePath,
  });
  @override
  Widget build(BuildContext context) {
  return  Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0,left: 10,right: 10),
        child: Container(
          height: 300,
          child: Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child:

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Image.asset(
                        this.imagePath,
                        width: 150,
                        height: 150,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 1, right: 1, top: 10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child:
                            Text(
                                this.text,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF444444),
                                    fontFamily: CommonConstants.largeTextFont,
                                    fontSize: CommonConstants.meduimText,
                                    fontWeight: FontWeight.bold)),),

                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );

  }
}