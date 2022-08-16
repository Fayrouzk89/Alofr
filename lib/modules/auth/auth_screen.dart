import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/utils/size_config.dart';
import '../../shared/widgets/SharedWidget/FooterWidget.dart';
import '../../shared/widgets/border_button.dart';
import '../../shared/widgets/custom_rounded.dart';
import '../../shared/widgets/gradient_button.dart';
import '../../shared/widgets/AppBars/main_app_bar_long.dart';
import 'auth_controller.dart';

class AuthScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: ColorConstants.greyBack,
        appBar: MainAppBarLong(),
        body: Stack(
          children: [
            Padding(
              padding:  EdgeInsets.only(bottom: CommonConstants.paddingBottom),
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: CommonConstants.paddingHorizontal),
                child: _buildItems(context)
              ),
            ),
            FooterWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      children: [
        Material(
          elevation: 8.0,
          shape: CircleBorder(),
          color: Colors.transparent,
          child: CircleAvatar(
            backgroundImage:
            AssetImage('images/logo.jpg'),
            radius:  SizeConfig().screenWidth * 0.2,
          ),
        ),
        Text(
          LocalString.getStringValue(context,'welcome')?? "",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: CommonConstants.largeText,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headline6!.color,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.center,
            margin:  EdgeInsets.symmetric(horizontal: CommonConstants.horizontalPaddingButton, vertical: CommonConstants.verticalPaddingButton),
            child: CustomRounded(
                text: LocalString.getStringValue(context,'create_account')?? "انشاء حساب",
                textSize: CommonConstants.textButton,
                textColor: ColorConstants.greenColor,
                color: Colors.white,
                size: Size(SizeConfig().screenWidth  * 0.8, CommonConstants.roundedHeight),
                pressed: () {
    Get.toNamed(Routes.AUTH + Routes.REGISTER, arguments: controller);
    },
            )),
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: CommonConstants.horizontalPaddingButton, vertical: CommonConstants.verticalPaddingButton),
            child: CustomRounded(
                 text: LocalString.getStringValue(context,'sign_in')?? "تسجيل الدخول",
                textSize: CommonConstants.textButton,
                textColor: Colors.white,
                color: ColorConstants.greenColor,
                size: Size(SizeConfig().screenWidth  * 0.8, CommonConstants.roundedHeight),
                pressed: () {
                  Get.toNamed(Routes.AUTH + Routes.LOGIN, arguments: controller);
            })),
        SizedBox(height: 10.0),

        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.HOME);
          },
          child: Text(
            LocalString.getStringValue(context, 'continue_as_guest') ??
                "متابعة كضيف",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: CommonConstants.normalText,
                color: ColorConstants.textColor,
                fontFamily: CommonConstants.largeTextFont,
                fontWeight: FontWeight.bold
            ),
          ),
        ),

        /*
        GradientButton(
          text: 'Sign In',
          onPressed: () {
            Get.toNamed(Routes.AUTH + Routes.LOGIN, arguments: controller);
          },
        ),
        SizedBox(height: 20.0),
        BorderButton(
          text: 'Sign Up',
          onPressed: () {
            Get.toNamed(Routes.AUTH + Routes.REGISTER, arguments: controller);
          },
        ),

         */

      ],
    );
  }
}
