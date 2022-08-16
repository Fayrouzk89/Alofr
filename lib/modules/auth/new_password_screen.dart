import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
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

class NewPasswordScreen extends StatefulWidget {
  @override
  State<NewPasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<NewPasswordScreen> {
  final AuthController controller = Get.arguments;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          //resizeToAvoidBottomInset: false,
          appBar: ForgetAppBar(
              LocalString.getStringValue(context, 'welcome_back') ??
                  "أهلا بعودتك",
              true),
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

  Widget _buildForms(BuildContext context) {
    return Form(
      key: controller.newPasswordFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  LocalString.getStringValue(context, 'enter_new_code_here') ??
                      "أدخل الرقم السري الجديد",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: CommonConstants.normalText,
                      color: ColorConstants.textColor,
                      fontFamily: CommonConstants.largeTextFont),
                )),
            CommonWidget.rowHeight(height: 20),
            InputPassword(
              controller: controller.newPasswordEditingController,
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

                if(value!=null) {
                  if (!Regex.isPassword(value)) {
                    return LocalString.getStringValue(context, 'password_error') ??
                        'خطأ في صيغة كلمة السر';
                  }
                }

                return null;
              },
              icon: Icons.lock,
            ),
            CommonWidget.rowHeight(height: 10.0),
            InputPassword(
              controller: controller.newPasswordConfirmPasswordController,
              keyboardType: TextInputType.text,
              // labelText: 'Password',
              placeholder:
              LocalString.getStringValue(context, 'enter_secret_confirm') ??
                  'ادخل تأكيد الرمز السري',
              password: true,

              validator: (value) {
                if (value!.isEmpty) {
                  return LocalString.getStringValue(
                      context, 'password_required') ??
                      'تأكيد الرمز السري حق مطلوب';
                }

                if(value!=null) {
                  if (!Regex.isPassword(value)) {
                    return LocalString.getStringValue(context, 'password_error') ??
                        'خطأ في صيغة كلمة السر';
                  }
                }
                if (controller.newPasswordEditingController.text !=
                    controller.newPasswordConfirmPasswordController.text) {
                  return LocalString.getStringValue(
                      context, 'password_not_same') ??
                      'الرمز السري غير متطابق';
                }
                return null;
              },
              icon: Icons.lock,
            ),
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                horizontal: CommonConstants.horizontalPaddingButton,
                vertical: CommonConstants.verticalPaddingButton),
            child: CustomRounded(
                text: LocalString.getStringValue(context, 'sign') ??
                    "دخول",
                textSize: CommonConstants.textButton,
                textColor: Colors.white,
                color: ColorConstants.greenColor,
                size: Size(SizeConfig().screenWidth * 0.8,
                    CommonConstants.roundedHeight),
                pressed: () {
                  controller.newPassword(context,controller);
                })),

            //
          ],
        ),
      ),
    );
  }

}
