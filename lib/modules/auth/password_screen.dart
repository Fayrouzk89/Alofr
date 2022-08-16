import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/regex.dart';
import '../../shared/utils/size_config.dart';
import '../../shared/widgets/AppBars/forget_app_bar.dart';
import '../../shared/widgets/SharedWidget/FooterWidget.dart';
import '../../shared/widgets/AppBars/auth_app_bar.dart';
import '../../shared/widgets/border_button.dart';
import '../../shared/widgets/custom_rounded.dart';
import '../../shared/widgets/gradient_background.dart';
import '../../shared/widgets/input_field.dart';
import '../../shared/widgets/input_password.dart';
import 'auth_controller.dart';
import '../../globals.dart' as globals;
class PasswordScreen extends StatefulWidget {
  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final AuthController controller = Get.arguments;
  late DateTime alert;
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    alert = DateTime.now().add(Duration(seconds: 10, minutes: 2));
    errorController = StreamController<ErrorAnimationType>();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          //resizeToAvoidBottomInset: false,
          appBar: ForgetAppBar(
    (globals.activateMsg=="")?
    ( LocalString.getStringValue(context, 'code_send_activate') ??
        "تم ارسال كود تأكيد إلى رقم الهاتف الخاص بك"):globals.activateMsg
             ,
              false),
          backgroundColor: ColorConstants.greyBack,
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: CommonConstants.paddingBottom),
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: _buildForms(context),
                ),
              ),
              FooterWidget()
            ],
          ),
        ),
      ],
    );
  }


  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }
  Widget _buildForms(BuildContext context) {
    return Form(
      key: controller.passwordFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  LocalString.getStringValue(context, 'enter_code_here') ??
                      "ضع الكود هنا",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: CommonConstants.normalText,
                      color: ColorConstants.textColor,
                      fontFamily: CommonConstants.largeTextFont),
                )),
            CommonWidget.rowHeight(),
        Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 30),
            child: PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              length: 5,
              obscureText: true,
              obscuringCharacter: '*',

              //obscuringWidget:  FlutterLogo(
                //size: 40,
              //),
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (v) {
                if (v!.length < 5) {
                  return LocalString.getStringValue(context, 'code_length') ?? "طول الكود 5 محارف";
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                activeColor: ColorConstants.hintColor,
                selectedFillColor: ColorConstants.whiteBack,
                inactiveFillColor: ColorConstants.whiteBack,
                disabledColor: ColorConstants.greenColor,
                errorBorderColor: ColorConstants.greenColor,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 50,
                activeFillColor: Colors.white,
              ),
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              errorAnimationController:  errorController,
              controller: textEditingController,
              keyboardType: TextInputType.number,
              boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              onCompleted: (v) {
                debugPrint("Completed");
              },
              // onTap: () {
              //   print("Pressed");
              // },
              onChanged: (value) {
                debugPrint(value);
                setState(() {
                  controller.code=value;
                });
              },
              beforeTextPaste: (text) {
                debugPrint("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            )),
            CommonWidget.rowHeight(),
            buildTimer(),
            CommonWidget.rowHeight(),
            buildCode()
          ],
        ),
      ),
    );
  }

  Widget buildCode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  horizontal: CommonConstants.horizontalPaddingButton,
                  vertical: CommonConstants.verticalPaddingButton),
              child: CustomRounded(
                  text:
                      LocalString.getStringValue(context, 'confirm') ?? "تأكيد",
                  textSize: CommonConstants.textButton,
                  color: ColorConstants.greenColor,
                  textColor: ColorConstants.white,
                  size: Size(SizeConfig().screenWidth * 0.8,
                      CommonConstants.roundedHeight),
                  pressed: () {
                    controller.enterResetCode(context, controller);
                  })),
        ),
        Expanded(
          flex: 3,
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  horizontal: CommonConstants.horizontalPaddingButton,
                  vertical: CommonConstants.verticalPaddingButton),
              child: CustomRounded(
                  text: LocalString.getStringValue(context, 'edit_number') ??
                      "تعديل الرقم",
                  textSize: CommonConstants.textButton,
                  textColor: ColorConstants.greenColor,
                  color: ColorConstants.white,
                  size: Size(SizeConfig().screenWidth * 0.8,
                      CommonConstants.roundedHeight),
                  pressed: () {
                    Get.back();
                    //controller.register(context);
                  })),
        ),
      ],
    );
  }

  Widget buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            flex: 2,
            child: Text(
              LocalString.getStringValue(context, 'not_arrived') ??
                  "لم يصلك الرمز حتى الآن",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: CommonConstants.normalText,
                  color: ColorConstants.textColor,
                  fontFamily: CommonConstants.largeTextFont),
            )),
        Expanded(
          flex: 1,
          child: TimerBuilder.scheduled([alert], builder: (context) {
            // This function will be called once the alert time is reached
            var now = DateTime.now();
            var reached = now.compareTo(alert) >= 0;
            final textStyle = TextStyle();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    reached ? Icons.alarm_on : Icons.alarm,
                    color: reached ? Colors.red : Colors.green,
                    size: 48,
                  ),
                  !reached
                      ? TimerBuilder.periodic(Duration(seconds: 1),
                          alignment: Duration.zero, builder: (context) {
                          // This function will be called every second until the alert time
                          var now = DateTime.now();
                          var remaining = alert.difference(now);
                          return Text(
                            formatDuration(remaining),
                            style: textStyle,
                          );
                        })
                      : Text(
                          LocalString.getStringValue(context, 'time_ended') ??
                              "انتهى الوقت",
                          style: textStyle),
                ],
              ),
            );
          }),
        )
      ],
    );
  }

  String formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // We want to round up the remaining time to the nearest second
    d += Duration(microseconds: 999999);
    return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
  }
}
