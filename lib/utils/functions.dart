// ignore_for_file: unused_import

import 'dart:io';

import 'dart:typed_data';
// ignore: depend_on_referenced_packages
import 'package:file_picker/file_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class Functions {
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static void saveInvoice({
    required String name,
    required Uint8List fileBytes,
    String path = "/storage/emulated/0/Documents",
  }) async {
    try {
      bool checkPermission = await Permission.storage.request().isGranted;
      if (checkPermission) {
        // ignore: non_constant_identifier_names
        File pdf_doc = File("$path/$name");
        await pdf_doc.writeAsBytes(fileBytes);
        Get.snackbar("done", "Invoice Saved Successfully to $path/$name",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", "Storage permission denied!, please try again",
            snackPosition: SnackPosition.BOTTOM);
        Future.delayed(
          const Duration(seconds: 2),
        );
        await Permission.storage.request();
      }
    } on FileSystemException catch (e) {
      Get.snackbar("Error", "${e.message} $path/$name",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
