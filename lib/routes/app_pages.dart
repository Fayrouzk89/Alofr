import 'package:billing/modules/lang/lang.dart';
import 'package:billing/modules/my_ads/my_ads_binding.dart';
import 'package:get/get.dart';

import '../modules/Allproducts/all_products_binding.dart';
import '../modules/Allproducts/products_screen.dart';
import '../modules/StatisticPage/about_screen.dart';
import '../modules/StatisticPage/privacy_screen.dart';
import '../modules/StatisticPage/statistic_binding.dart';
import '../modules/StatisticPage/terms_condition_screen.dart';
import '../modules/auth/activate_screen.dart';
import '../modules/auth/auth_binding.dart';
import '../modules/auth/auth_screen.dart';
import '../modules/auth/forget_screen.dart';
import '../modules/auth/login_screen.dart';
import '../modules/auth/new_password_screen.dart';
import '../modules/auth/password_screen.dart';
import '../modules/auth/register_screen.dart';
import '../modules/buy/buy_binding.dart';
import '../modules/buy/buy_screen.dart';
import '../modules/company/company_binding.dart';
import '../modules/company/company_screen.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_screen.dart';
import '../modules/my_ads/my_ads_screen.dart';
import '../modules/notifications/notification_screen.dart';
import '../modules/notifications/notifications_binding.dart';
import '../modules/packages/defaultPackagesBinding.dart';
import '../modules/packages/defaultPackagesScreen.dart';
import '../modules/product_details/product_binding.dart';
import '../modules/product_details/product_details_screen.dart';
import '../modules/search/search_binding.dart';
import '../modules/search/search_screen.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_screen.dart';
import '../globals.dart' as globals;
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
        GetPage(name: Routes.activate, page: () => ActivateScreen()),

      ],
    ),
    GetPage(
        name: Routes.LOGIN,
        page: () => LoginScreen(),
        binding: AuthBinding(),
        ),

    GetPage(
        name: Routes.HOME,
        page: () => HomeScreen(),
        binding: HomeBinding(),

    ),
    GetPage(
        name: Routes.Lang,
        page: () => LangScreen(),
        binding: LangBinding(),
       ),
    GetPage(
        name: Routes.buy,
        page: () => BuyScreen(),
        binding: BuyBinding(),
    ),
    GetPage(
      name: Routes.defaultPackages,
      page: () => DefaultPackagesScreen(),
      binding: DefaultPackageBinding(),
    ),

    GetPage(
        name: Routes.allProducts,
        page: () => ProductsScreen(categoryId: -1,categoryName: '',),
        binding:ProductsBinding()
    ),
    GetPage(
        name: Routes.MyAdsScreen,
        page: () => MyAdsScreen(),
        binding:MyAdsBinding()
    ),
    GetPage(
        name: Routes.companies,
        page: () => CompanyScreen(),
        binding:CompanyBinding()
    ),
    GetPage(
        name: Routes.details,
        page: () => DetailsScreen(product: globals.product,),
        binding:DetailsBinding()),
    GetPage(
        name: Routes.staticPages,
        page: () => AboutScreen(),
        binding: StatBinding()
    ),
    GetPage(
        name: Routes.Terms,
        page: () => TermsConditionScreen(),
        binding: StatBinding()
    ),
    GetPage(
        name: Routes.Privacy,
        page: () => PrivacyScreen(),
        binding: StatBinding()
    ),
    GetPage(
        name: Routes.Search,
        page: () => SearchScreen(Name: '',),
        binding: SearchBinding()
    ),
    GetPage(
        name: Routes.Notification,
        page: () => NotificationScreen(),
        binding: NotificationBinding()),

  ];
}
