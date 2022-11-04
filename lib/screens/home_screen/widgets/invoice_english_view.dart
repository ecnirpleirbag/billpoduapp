// ignore_for_file: camel_case_types, must_be_immutable

import 'package:biil_podu_app/env/dimensions.dart';
import 'package:biil_podu_app/models/invoice_model.dart';
import 'package:biil_podu_app/screens/invoices_screen/invoice_preview/pdf_api.dart';
import 'package:biil_podu_app/screens/shared_widgets/custom_text.dart';
import 'package:biil_podu_app/utils/functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class InvoiceView_eng extends StatelessWidget {
  Invoice invoice;
  InvoiceView_eng({
    required this.invoice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void shareInvoice({
      String path = "/storage/emulated/0/Documents",
    }) async {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      List<String>? files =
          result?.files.map((e) => e.path).cast<String>().toList();

      if (files == null) return;
      // ignore: deprecated_member_use
      await Share.shareFiles(files);
      // ignore: avoid_print
    }

    return InkWell(
      onTap: () async => Functions.saveInvoice(
        name: "invoice-${invoice.id}.pdf",
        fileBytes: await PdfInvoiceApi.generate(invoice),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: Dimensions.calcH(20),
          horizontal: Dimensions.calcW(8),
        ),
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.calcH(5),
          horizontal: Dimensions.calcW(8),
        ),
        height: Dimensions.calcH(100),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              text: "Invoice ID #${invoice.id}",
                              align: TextAlign.left,
                              fontSize: Dimensions.calcH(21),
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              text: invoice.to.name,
                              align: TextAlign.left,
                              fontSize: Dimensions.calcH(18),
                              weight: FontWeight.w600,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              text: invoice.date,
                              align: TextAlign.left,
                              fontSize: Dimensions.calcH(18),
                              weight: FontWeight.w600,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () async => shareInvoice()),
                ),
              )
            ]),
      ),
    );
  }
}
