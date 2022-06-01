import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/services/storage_service.dart';
import '../../shared/utils/size_config.dart';
import '../../shared/widgets/custom_rounded.dart';
import '../../shared/widgets/AppBars/main_app_bar.dart';
import 'lang_controller.dart';
import '../../globals.dart' as globals;

class LangScreen extends GetView<LangController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorConstants.whiteBack,
        appBar: MainAppBar(title: "الوفرة"),
        body:
        Stack(
            children: <Widget>[
              Positioned(
                top: SizeConfig().screenHeight  * 0.1,
                left: 0,
                right: 0,
                child:  _buildItems(context)
              ),
            ]
        )

      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(1.0),
      children: [
        Text(
          LocalString.getStringValue(context, 'choose_lang') ??
              "اختر اللغة",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: CommonConstants.largeTextFont,
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
                text: 'العربية',
                textSize: CommonConstants.textButton,
                textColor: ColorConstants.greenColor,
                color: Colors.white,
                size: Size(SizeConfig().screenWidth  * 0.8, CommonConstants.roundedHeight),
                pressed: () => chooseLang(context,1))),
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: CommonConstants.horizontalPaddingButton, vertical: CommonConstants.verticalPaddingButton),
            child: CustomRounded(
                text: 'English',
                textSize: CommonConstants.textButton,
                textColor: Colors.white,
                color: ColorConstants.greenColor,
                size: Size(SizeConfig().screenWidth  * 0.8, CommonConstants.roundedHeight),
                pressed: () => chooseLang(context,2))),
      ],
    );
  }
  chooseLang(BuildContext buildContext,int lang)
  {
    if(lang==1)
    StorageService.saveLang("ar");
    else
      {
        StorageService.saveLang("en");
      }
    Locale _appLocale = Locale(globals.defaultLang);
    if(globals.lang=="ar") {
      _appLocale = Locale('ar');
    }
    else
    {
      _appLocale = Locale("en");
    }

    Get.updateLocale(_appLocale);
    Get.toNamed(Routes.AUTH);
  }
}
