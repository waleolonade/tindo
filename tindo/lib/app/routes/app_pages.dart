import 'package:get/get.dart';

import '../modules/Coins/bindings/coins_binding.dart';
import '../modules/Coins/views/coins_view.dart';
import '../modules/Messages/bindings/messages_binding.dart';
import '../modules/Messages/views/messages_view.dart';
import '../modules/My_App/bindings/my_app_binding.dart';
import '../modules/My_App/views/my_app_view.dart';
import '../modules/Show_Post/bindings/show_post_binding.dart';
import '../modules/Show_Post/views/show_post_view.dart';
import '../modules/Splash_Screen/bindings/splash_screen_binding.dart';
import '../modules/Splash_Screen/views/splash_screen_view.dart';
import '../modules/User_Profile/bindings/user_profile_binding.dart';
import '../modules/User_Profile/views/user_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.MY_APP,
      page: () => const MyApp(),
      binding: MyAppBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGES,
      page: () => MessagesView(),
      binding: MessagesBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_POST,
      page: () => const ShowPostView(),
      binding: ShowPostBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: _Paths.COINS,
      page: () => const CoinsView(),
      binding: CoinsBinding(),
    ),
  ];
}
