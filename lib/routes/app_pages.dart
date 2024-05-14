import 'package:get/get.dart';

import '../page/login_page.dart';


/// part 和  part of 是成对使用的
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const init = Routes.MAIN;

  static final routes = [
    // GetPage(
    //     name: Routes.MAIN,
    //     page: () => const MainPage(),
    //     binding: MainBinding()),
    GetPage(
        name: Routes.LOGING,
        page: () => const LoginPage(),)
  ];
}
