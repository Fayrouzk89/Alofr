import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
import '../../shared/widgets/input_field_phone.dart';
import '../../shared/widgets/input_password.dart';
import 'auth_controller.dart';

class ForgetScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          //resizeToAvoidBottomInset: false,
          appBar: ForgetAppBar( LocalString.getStringValue(context, 'forget_password') ??
              "هل نسيت كلمة السر",true),
          backgroundColor: ColorConstants.greyBack,
          body: Stack(
            children: [
              Padding(
                padding:  EdgeInsets.only(bottom: CommonConstants.paddingBottom),
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
      key: controller.forgetFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  LocalString.getStringValue(context, 'enter_phone') ??
                      "أدخل رقم الهاتف",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: CommonConstants.normalText,
                      color: ColorConstants.textColor,
                      fontFamily: CommonConstants.largeTextFont,
                      fontWeight:
                      FontWeight.bold
                  ),
                )),
            CommonWidget.rowHeight(height: 20),
            InputFieldPhone(
              controller: controller.forgetPhoneController,
              keyboardType: TextInputType.text,
              //labelText: 'Email address',
              placeholder: LocalString.getStringValue(context, 'enter_phone_hint') ??
                  'مثال 00962919191911',
              validator: (value) {
                if (value!.isEmpty) {
                  return LocalString.getStringValue(
                      context, 'phone_required') ??
                      'رقم الهاتف حقل مطلوب';
                }
                if (value.length != CommonConstants.phoneLength) {
                  return LocalString.getStringValue(context, 'phone_length') ??
                      'طول الرقم 10 حروف';
                }
                if (value != null) {
                  if (!Regex.isPhone(value)) {
                    return LocalString.getStringValue(context, 'phone_error') ??
                        'خطأ في صيغة الهاتف';
                  }
                }
                return null;

              },
              icon: Icons.phone,
            ),
            CommonWidget.rowHeight(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: CommonConstants.horizontalPaddingButton,
                          vertical: CommonConstants.verticalPaddingButton),
                      child: CustomRounded(
                          text: LocalString.getStringValue(context, 'next') ??
                              "التالي",
                          textSize: CommonConstants.textButton,
                          color: ColorConstants.greenColor,
                          textColor: ColorConstants.white,
                          size: Size(SizeConfig().screenWidth * 0.8,
                              CommonConstants.roundedHeight),
                          pressed: () {

                          controller.forget(context,controller);
                          })),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: CommonConstants.horizontalPaddingButton,
                          vertical: CommonConstants.verticalPaddingButton),
                      child: CustomRounded(
                          text: LocalString.getStringValue(context, 'back') ??
                              "رجوع",
                          textSize: CommonConstants.textButton,
                          textColor   : ColorConstants.greenColor,
                      color : ColorConstants.white,
                          size: Size(SizeConfig().screenWidth * 0.8,
                              CommonConstants.roundedHeight),
                          pressed: () {
                            Get.back();
                            //controller.register(context);
                          })),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


