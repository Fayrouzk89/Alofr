import 'dart:io';
import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import '../../globals.dart' as globals;
class DialogExit extends StatefulWidget {
 final BuildContext mcontext;
  DialogExit( this.mcontext);

  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<DialogExit> {
  Color _c = Colors.redAccent;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          AlertDialog(
            title: Container(
             // height: 30,
              child: Center(
                child: Text(
                  globals.lang=="ar"?
                  "تأكيد":
                  "Are you sure",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
            content: Container(
             // height: 30,
              child: Center(
                child: Text(
                    globals.lang=="ar"?
                    "هل تريد الخروج من التطبيق؟":
                    "Do you want to exit an App?"),
              ),
            ),
            actions: <Widget>[
              FlatButton(

                /*Navigator.of(context).pop(true)*/
                  onPressed: () {  },
                  child:
                  Container(
                   // width: 100,
                    child: RaisedButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: Text(
                        globals.lang=="ar"?
                        "نعم":
                        "Yes",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: ColorConstants.greenColor,
                    ),
                  )

              ),
              FlatButton(

                onPressed: () {

                },
                child: Container(
                  //  width: 100,
                    child:
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        globals.lang=="ar"?
                        "لا":
                        "No",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                    )


                ),
              ),

            ],

          ),
        ],
      ),
    );
  }

}