import 'package:biil_podu_app/constants/colors.dart';
import 'package:biil_podu_app/constants/strings.dart';
import 'package:biil_podu_app/env/dimensions.dart';
import 'package:biil_podu_app/screens/shared_widgets/custom_btn.dart';
import 'package:biil_podu_app/screens/shared_widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  checkifLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/invoice_logo.svg",
            height: Dimensions.calcH(120),
            color: Colors.white,
          ),
          SizedBox(
            height: Dimensions.calcH(15),
          ),
          CustomText(
            text: AppStrings.APP_NAME,
            color: Colors.white,
            weight: FontWeight.bold,
            fontSize: Dimensions.calcH(25),
          ),
          SizedBox(
            height: Dimensions.calcH(15),
          ),
          CustomText(
            text: AppStrings.APP_DESC,
            color: Colors.white,
            weight: FontWeight.w600,
            height: 1.3,
            fontSize: Dimensions.calcH(18),
          ),
          SizedBox(
            height: Dimensions.calcH(15),
          ),
          CustomBtn(
            label: AppStrings.START_BTN,
            action: () {
              isLogin ? Get.toNamed('/home') : Get.toNamed('/login');
            },
          )
        ],
      )),
    );
  }
}
