import 'package:biil_podu_app/env/routing.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51LzzarSJYZDrwHa3B6WRLTvVNcKO03OTBMKBKuI2cPToRiUU9isX91jqwPgkysQdh1U0CWFiuBJM9BndveE1FRl400IuIVvK5Q';
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    initialRoute: "/",
    getPages: AppRouting.ROUTES,
  ));
}
