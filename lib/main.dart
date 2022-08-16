// @dart=2.9
import 'dart:io';

import 'package:billing/AppLocalizations.dart';
import 'package:billing/LocalNotificationService.dart';
import 'package:billing/routes/app_pages.dart';
import 'package:billing/shared/services/NotificationFunction.dart';
import 'package:billing/shared/services/storage_service.dart';
import 'package:billing/theme/theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'api/HttpOverrides.dart';
import 'app_binding.dart';
import 'di.dart';
import 'shared/constants/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'globals.dart' as globals;
import 'shared/services/LocalString.dart';
Future<void> backgroundHandler(RemoteMessage message) async{
  print(message.data.toString());
  print(message.notification.title);
}
String token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();

  await DenpendencyInjection.init();
  //for firebase

 // await Firebase.initializeApp();
  await Firebase.initializeApp().whenComplete(() {
    print("completed");
    FirebaseMessaging.instance.subscribeToTopic(globals.generalTopic);
    FirebaseMessaging.instance.getToken().then((value) {
      String token = value;
      print(token);
       NotificationFunction.SaveFCM(token);
    });
  });

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);


  //for firebase


  runApp(App());
  configLoading();
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //for firebase
     initNotifications();






  }
  void initNotifications()async
  {

    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if(message != null){
        final routeFromMessage = message.data["route"];

        // Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null){
        print(message.notification.body);
        print(message.notification.title);
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }
  final ThemeData lightTheme = ThemeData.light().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.white,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // Dark Theme
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.grey,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: ColorConstants.greenColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: LoadLang(context),
      builder: (buildContext, snapshot) {

        if((snapshot.hasData)) {
          if(snapshot.data!=null){
            // Return your login here
            return
              GetMaterialApp(
                debugShowCheckedModeBanner: false,
                enableLog: true,

                initialRoute: Routes.SPLASH,
                defaultTransition: Transition.fade,
                getPages: AppPages.routes,
                initialBinding: AppBinding(),
                theme: ThemeConfig.lightTheme,
                // darkTheme: darkTheme,
                //themeMode: ThemeMode.light,
                smartManagement: SmartManagement.keepFactory,
                title: 'WfraTik',
                // locale: TranslationService.locale,
                // fallbackLocale: TranslationService.fallbackLocale,
                //  translations: TranslationService(),

                //builder: EasyLoading.init(),
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
                  builder:(context,child){
                    child = EasyLoading.init()(context,child);
                    final mediaQueryData = MediaQuery.of(context);
                    final scale = mediaQueryData.textScaleFactor.clamp(1, 1.1);
                    return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
                        child: child);
                  }
              )
             ;
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

  Future<bool>LoadLang(BuildContext context)async
  {
   await LocalString.LoadLang();
   await StorageService.LoadToken();

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
