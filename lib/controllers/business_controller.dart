// ignore_for_file: unused_label

import 'package:biil_podu_app/controllers/invoice_controller.dart';
import 'package:biil_podu_app/models/business_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessController extends GetxController {
  Business? business;
  TextEditingController businessNameInputController = TextEditingController();
  TextEditingController businessEmailInputController = TextEditingController();
  TextEditingController businessPhoneInputController = TextEditingController();
  TextEditingController businessAddressInputController =
      TextEditingController();

  //validate input

  bool validate() {
    if (businessNameInputController.text.isEmpty ||
        businessEmailInputController.text.isEmpty ||
        businessPhoneInputController.text.isEmpty ||
        businessAddressInputController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please Fill all the required fields",
        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    } else {
      business = Business(
          name: businessNameInputController.text,
          address: businessAddressInputController.text,
          phone: businessPhoneInputController.text,
          email: businessEmailInputController.text,
          logo: Get.find<InvoiceController>().logo);
      return true;
    }
  }

  @override
  void onClose() {
    if (business != null) {
      name:
      businessNameInputController.clear();
      address:
      businessAddressInputController.clear();
      phone:
      businessPhoneInputController.clear();
      email:
      businessEmailInputController.clear();
      logo:
      Get.find<InvoiceController>().setBusiness(business!);
    }
    super.onClose();
  }
}
