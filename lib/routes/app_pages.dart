import 'package:billing/modules/lang/lang.dart';
import 'package:get/get.dart';

import '../modules/appmain/BillsScreen.dart';
import '../modules/auth/auth_binding.dart';
import '../modules/auth/auth_screen.dart';
import '../modules/auth/forget_screen.dart';
import '../modules/auth/login_screen.dart';
import '../modules/auth/new_password_screen.dart';
import '../modules/auth/password_screen.dart';
import '../modules/auth/register_screen.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_screen.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => AuthScreen(),
      binding: AuthBinding(),
      children: [
        GetPage(name: Routes.REGISTER, page: () => RegisterScreen()),
        GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
        GetPage(name: Routes.Forget, page: () => ForgetScreen()),
        GetPage(name: Routes.Reset, page: () => PasswordScreen()),
        GetPage(name: Routes.NewPassword, page: () => NewPasswordScreen()),

      ],
    ),
    GetPage(
        name: Routes.HOME,
        page: () => HomeScreen(),
        binding: HomeBinding(),
        children: [
          GetPage(name: Routes.CARDS, page: () => BillsScreen()),
        ]),
    GetPage(
        name: Routes.Lang,
        page: () => LangScreen(),
        binding: LangBinding(),
        children: [
          GetPage(name: Routes.HOME, page: () => BillsScreen()),
        ]),
  ];
}
