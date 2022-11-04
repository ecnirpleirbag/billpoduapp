import 'package:biil_podu_app/env/links.dart';
import 'package:biil_podu_app/screens/Login_screen/signup_screen.dart';
import 'package:biil_podu_app/screens/payment_screen/payment_homescreen.dart';
import 'package:get/get.dart';
import 'package:biil_podu_app/screens/screens.dart';

import '../screens/Login_screen/login_screen.dart';

class AppRouting {
  // ignore: non_constant_identifier_names
  static final ROUTES = [
    GetPage(
      name: AppLinks.SPLASHSCREEN,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: AppLinks.HOME,
        page: () => const HomeScreen(),
        transition: Transition.circularReveal,
        binding: HomeBinding()),
    GetPage(
      name: AppLinks.NEW_INVOICE,
      page: () => const NewInvoiceScreen(),
      transition: Transition.fadeIn,
      binding: NewInvoiceBinding(),
    ),
    GetPage(
      name: AppLinks.NEW_BUSSINESS,
      page: () => const NewBusinessScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
        name: AppLinks.NEW_PAYER,
        page: () => const NewPayerScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
      name: AppLinks.NEW_ITEM,
      page: () => const NewItemScreen(),
      transition: Transition.rightToLeftWithFade,
      binding: ItemsBinding(),
    ),
    GetPage(
      name: AppLinks.SIGNATURE,
      page: () => const SignatureScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppLinks.PREVIEW,
      page: () => InvoicePreviewScreen(),
    ),
    GetPage(
      name: AppLinks.CUSTOMER,
      page: () => const CustomerListscreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppLinks.PRODUCT,
      page: () => const ProductListscreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppLinks.PROFILE,
      page: () => const Profilescreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppLinks.CUSTINFO,
      page: () => const CustomerInfoscreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppLinks.LOGIN,
      page: () => LoginScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppLinks.SIGNUP,
      page: () => SignupScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppLinks.PAYMENT,
      page: () => const PaymentHomepage(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
