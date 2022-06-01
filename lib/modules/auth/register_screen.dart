import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/regex.dart';
import '../../shared/utils/size_config.dart';
import '../../shared/widgets/SharedWidget/FooterWidget.dart';
import '../../shared/widgets/app_check_box.dart';
import '../../shared/widgets/AppBars/auth_app_bar.dart';
import '../../shared/widgets/border_button.dart';
import '../../shared/widgets/custom_rounded.dart';
import '../../shared/widgets/gradient_background.dart';
import '../../shared/widgets/input_field.dart';
import '../../shared/widgets/input_password.dart';
import 'auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          //resizeToAvoidBottomInset: false,
          appBar: AuthAppBar(),
          backgroundColor: ColorConstants.whiteBack,
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
    String? selectedValue;
    String? selectedCompany;
    final List<String> genderItems = [
      LocalString.getStringValue(context, 'male') ?? "ذكر",
      LocalString.getStringValue(context, 'female') ?? "أنثى",
    ];
    final List<String> companyItems = [
      LocalString.getStringValue(context, 'individual') ?? "فرد",
      LocalString.getStringValue(context, 'company') ?? "شركة",
    ];
    return Form(
      key: controller.registerFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  LocalString.getStringValue(context, 'create_account') ??
                      "أنشئ حساب",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: CommonConstants.normalText,
                      color: ColorConstants.textColor,
                      fontFamily: CommonConstants.largeTextFont),
                )),
            CommonWidget.rowHeight(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  // optional flex property if flex is 1 because the default flex is 1
                  flex: 1,
                  child: InputField(
                    controller: controller.registerFirstController,
                    keyboardType: TextInputType.text,
                    //labelText: 'Email address',
                    placeholder:
                        LocalString.getStringValue(context, 'first_name') ??
                            'الاسم الأول',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocalString.getStringValue(
                                context, 'first_required') ??
                            'الاسم حقل مطلوب';
                      }

                      return null;
                    },
                    icon: Icons.person,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  // optional flex property if flex is 1 because the default flex is 1
                  flex: 1,
                  child: InputField(
                    controller: controller.registerLastController,
                    keyboardType: TextInputType.text,
                    //labelText: 'Email address',
                    placeholder:
                        LocalString.getStringValue(context, 'last_name') ??
                            'الاسم الأخير',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocalString.getStringValue(
                                context, 'last_required') ??
                            'الكنية حقل مطلوب';
                      }
                      return null;
                    },
                    icon: Icons.person,
                  ),
                ),
              ],
            ),
            CommonWidget.rowHeight(height: 10.0),
            InputField(
              controller: controller.registerPhoneController,
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
                if (value!=null ) {
                  if (!Regex.isPhone(value)) {
                    return LocalString.getStringValue(context, 'phone_error') ??
                        'خطأ في صيغة الهاتف';
                  }
                }
                return null;
              },
              icon: Icons.phone,
            ),
            CommonWidget.rowHeight(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  // optional flex property if flex is 1 because the default flex is 1
                  flex: 1,
                  child: Container(
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        focusColor: Colors.grey.shade100,
                        focusedBorder:   OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      hint: Text(
                        LocalString.getStringValue(context, 'select_gender') ??
                            'اختر الجنس',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 50,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorConstants.white),
                      items: genderItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return LocalString.getStringValue(
                                  context, 'gender_required') ??
                              'اختر الجنس';
                        }
                      },
                      onChanged: (value) {
                        //Do something when changing the item if you want.
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  // optional flex property if flex is 1 because the default flex is 1
                  flex: 1,
                  child: Container(
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        focusColor: Colors.grey.shade100,
                        focusedBorder:   OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      hint: Text(
                        LocalString.getStringValue(context, 'select_company') ??
                            'اختر شركة',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 50,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorConstants.white),
                      items: companyItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return LocalString.getStringValue(
                                  context, 'select_company') ??
                              'فرد أو شركة';
                        }
                      },
                      onChanged: (value) {},
                      onSaved: (value) {
                        selectedCompany = value.toString();
                      },
                    ),
                  ),
                ),
              ],
            ),
            CommonWidget.rowHeight(height: 10),
            InputPassword(
              controller: controller.registerPasswordController,
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
            CommonWidget.rowHeight(height: 10.0),
            InputPassword(
              controller: controller.registerConfirmPasswordController,
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

                if (value.length < 6 || value.length > 15) {
                  return LocalString.getStringValue(
                          context, 'password_error') ??
                      '>6 <15';
                }
                if (controller.registerPasswordController.text !=
                    controller.registerConfirmPasswordController.text) {
                  return LocalString.getStringValue(
                      context, 'password_not_same') ??
                      'الرمز السري غير متطابق';
                }
                return null;
              },
              icon: Icons.lock,
            ),
            CommonWidget.rowHeight(height: 10.0),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: CommonConstants.horizontalPaddingButton,
                    vertical: CommonConstants.verticalPaddingButton),
                child: CustomRounded(
                    text: LocalString.getStringValue(context, 'create_account') ??
                        "انشاء حساب",
                    textSize: CommonConstants.textButton,
                    textColor: Colors.white,
                    color: ColorConstants.greenColor,
                    size: Size(SizeConfig().screenWidth * 0.8,
                        CommonConstants.roundedHeight),
                    pressed: () {
                      controller.register(context);
                    })),
          ],
        ),
      ),
    );
  }
}
