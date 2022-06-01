import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/regex.dart';
import '../../shared/utils/size_config.dart';
import '../../shared/widgets/SharedWidget/FooterWidget.dart';
import '../../shared/widgets/AppBars/auth_app_bar.dart';
import '../../shared/widgets/border_button.dart';
import '../../shared/widgets/custom_rounded.dart';
import '../../shared/widgets/gradient_background.dart';
import '../../shared/widgets/input_field.dart';
import '../../shared/widgets/input_password.dart';
import 'auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AuthAppBar(),
          backgroundColor: ColorConstants.whiteBack,
          body:  Stack(
            children: [
              Padding(
                padding:  EdgeInsets.only(bottom: CommonConstants.paddingBottom),
                child: Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(horizontal: CommonConstants.paddingHorizontal),
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

  void onClick() {}

  Widget _buildForms(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonWidget.rowHeight(height: 10),
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  LocalString.getStringValue(context, 'sign_in') ??
                      "تسجيل الدخول",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: CommonConstants.normalText,
                      color: ColorConstants.textColor,
                      fontFamily: CommonConstants.largeTextFont),
                )),
            CommonWidget.rowHeight(height: 20),
            InputField(
              controller: controller.loginStaffController,
              keyboardType: TextInputType.text,
              //labelText: 'Email address',
              placeholder: LocalString.getStringValue(context, 'enter_phone') ??
                  'ادخل رقم الهاتف',
              validator: (value) {
                if (value!.isEmpty) {
                  return LocalString.getStringValue(
                          context, 'phone_required') ??
                      'رقم الهاتف حقل مطلوب';
                }
                if(value!=null) {
                  if (!Regex.isPhone(value)) {
                    return LocalString.getStringValue(context, 'phone_error') ??
                        'خطأ في صيغة الهاتف';
                  }
                }
                return null;
              },
              icon: Icons.phone,
            ),

            CommonWidget.rowHeight(height: 10),
            InputPassword(
              controller: controller.loginPasswordController,
              keyboardType: TextInputType.text,
              // labelText: 'Password',
              placeholder:
                  LocalString.getStringValue(context, 'enter_secret') ??
                      'ادخل الرمز السري',
              password: true,

              validator: (value) {
                if (value!.isEmpty) {
                  return LocalString.getStringValue(
                          context, 'password_required') ??
                      'الرمز السري حق مطلوب';
                }

                if (value.length < 6 || value.length > 15) {
                  return LocalString.getStringValue(
                          context, 'password_error') ??
                      '>6 <15';
                }

                return null;
              },
              icon: Icons.lock,
            ),
            CommonWidget.rowHeight(height: 10),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.AUTH + Routes.Forget,
                arguments: controller);
          },
              child: Text(
                LocalString.getStringValue(context, 'forget_password') ??
                    "هل نسيت كلمة المرور",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: CommonConstants.normalText,
                    color: ColorConstants.textColor,
                    fontFamily: CommonConstants.largeTextFont,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            CommonWidget.rowHeight(height: 10),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: CommonConstants.horizontalPaddingButton,
                    vertical: CommonConstants.verticalPaddingButton),
                child: CustomRounded(
                    text: LocalString.getStringValue(context, 'sign_in') ??
                        "تسجيل الدخول",
                    textSize: CommonConstants.textButton,
                    textColor: Colors.white,
                    color: ColorConstants.greenColor,
                    size: Size(SizeConfig().screenWidth * 0.8,
                        CommonConstants.roundedHeight),
                    pressed: () {
                      controller.login(context);
                    })),
            CommonWidget.rowHeight(height: 10),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: CommonConstants.horizontalPaddingButton,
                    vertical: CommonConstants.verticalPaddingButton),
                child: CustomRounded(
                  text: LocalString.getStringValue(context, 'create_account') ??
                      "انشاء حساب",
                  textSize: CommonConstants.textButton,
                  textColor: ColorConstants.greenColor,
                  color: Colors.white,
                  size: Size(SizeConfig().screenWidth * 0.8,
                      CommonConstants.roundedHeight),
                  pressed: () {
                    Get.toNamed(Routes.AUTH + Routes.REGISTER,
                        arguments: controller);
                  },
                )),
            /*
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: CommonConstants.horizontalPaddingButton,
                    vertical: CommonConstants.verticalPaddingButton),
                child: CustomRounded(
                  text: LocalString.getStringValue(context, 'continue_as_guest') ??
                      "متابعة كضيف",
                  textSize: CommonConstants.textButton,
                  textColor: ColorConstants.white,
                  color: Colors.black54,
                  size: Size(SizeConfig().screenWidth * 0.8,
                      CommonConstants.roundedHeight),
                  pressed: () {
                    Get.toNamed(Routes.HOME);
                  },
                ))

             */

          ],
        ),
      ),
    );
  }
}
