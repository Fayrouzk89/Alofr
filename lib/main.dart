// @dart=2.9
import 'package:billing/AppLocalizations.dart';
import 'package:billing/routes/app_pages.dart';
import 'package:billing/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'app_binding.dart';
import 'di.dart';
import 'shared/constants/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'globals.dart' as globals;
import 'shared/services/LocalString.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DenpendencyInjection.init();

  runApp(App());
  configLoading();
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    /*
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: Routes.SPLASH,
      defaultTransition: Transition.fade,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      title: 'Flutter GetX Boilerplate',
      theme: ThemeConfig.lightTheme,
     // locale: TranslationService.locale,
     // fallbackLocale: TranslationService.fallbackLocale,
    //  translations: TranslationService(),
      builder: EasyLoading.init(),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ar', ''),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        new FallbackCupertinoLocalisationsDelegate(),
        //app-specific localization
        specificLocalizationDelegate

      ],
      locale: specificLocalizationDelegate.overriddenLocale ,
    );

     */
    return FutureBuilder<bool>(
      future: LoadLang(),
      builder: (buildContext, snapshot) {

        if((snapshot.hasData)) {
          if(snapshot.data!=null){
            // Return your login here
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              enableLog: true,
              initialRoute: Routes.SPLASH,
              defaultTransition: Transition.fade,
              getPages: AppPages.routes,
              initialBinding: AppBinding(),
              smartManagement: SmartManagement.keepFactory,
              title: 'Flutter GetX Boilerplate',
              theme: ThemeConfig.lightTheme,
              // locale: TranslationService.locale,
              // fallbackLocale: TranslationService.fallbackLocale,
              //  translations: TranslationService(),
              builder: EasyLoading.init(),
              supportedLocales: [
                Locale('en', 'US'),
                Locale('ar', ''),
              ],
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                new FallbackCupertinoLocalisationsDelegate(),
                //app-specific localization
                globals.specificLocalizationDelegate

              ],
              locale: globals.specificLocalizationDelegate.overriddenLocale ,
            );
          }

          // Return your home here
          return Container(color: ColorConstants.darkScaffoldBackgroundColor);
        } else {

          // Return loading screen while reading preferences
          return Center(child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.darkScaffoldBackgroundColor)
          ));
        }
      },
    );
  }
  Future<bool>LoadLang()async
  {
   await LocalString.LoadLang();
   return true;
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
  // ..indicatorSize = 45.0
    ..radius = 10.0
  // ..progressColor = Colors.yellow
    ..backgroundColor = ColorConstants.lightGray
    ..indicatorColor = hexToColor('#64DEE0')
    ..textColor = hexToColor('#64DEE0')
  // ..maskColor = Colors.red
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
