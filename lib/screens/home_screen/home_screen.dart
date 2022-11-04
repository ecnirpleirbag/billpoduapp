import 'package:biil_podu_app/constants/colors.dart';
import 'package:biil_podu_app/constants/strings.dart';
import 'package:biil_podu_app/controllers/invoices_controller.dart';
import 'package:biil_podu_app/env/dimensions.dart';
import 'package:biil_podu_app/screens/home_screen/widgets/invoice_english_view.dart';
import 'package:biil_podu_app/screens/shared_widgets/appbar_eng_view.dart';
import 'package:biil_podu_app/screens/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends GetView<AllInvoiceController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AllInvoiceController());
    return Scaffold(
      backgroundColor: AppColors.kSecondaryColor,
      appBar: AppBar_eng(
        title: AppStrings.HOME_TITLE,
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed("/new");
            },
            splashColor: AppColors.kSecondaryColor,
            customBorder: const CircleBorder(),
            child: SvgPicture.asset(
              "assets/icons/new_invoice.svg",
              height: Dimensions.calcH(25),
              color: AppColors.kPrimaryDark,
            ),
          ),
          SizedBox(
            width: Dimensions.calcW(15),
          ),
          SizedBox(
            width: Dimensions.calcW(8),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.invoiceList.isEmpty) {
          return Center(
            child: CustomText(
              text: AppStrings.HOME_NO_INVOICES,
              color: Colors.black,
              fontSize: Dimensions.calcH(20),
              weight: FontWeight.w600,
            ),
          );
        } else {
          return Column(
            children: [
              ...controller.invoiceList
                  .map((invoice) => InvoiceView_eng(
                        invoice: invoice,
                      ))
                  .toList()
            ],
          );
        }
      }),
      bottomNavigationBar: GNav(
        gap: 5,
        tabs: [
          GButton(
            onPressed: () {
              Get.toNamed("/home");
            },
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            onPressed: () {
              Get.toNamed("/customer");
            },
            icon: Icons.person_add,
            text: 'customer',
          ),
          GButton(
            onPressed: () {
              Get.toNamed("/product");
            },
            icon: Icons.shopping_basket,
            text: 'product',
          ),
          GButton(
            onPressed: () {
              Get.toNamed("/profile");
            },
            icon: Icons.person,
            text: 'profile',
          ),
        ],
      ),
    );
  }
}
