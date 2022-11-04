import 'package:biil_podu_app/models/invoice_model.dart';
import 'package:get/get.dart';

class AllInvoiceController extends GetxController {
  final RxList _invoiceList = [].obs;

  get invoiceList => _invoiceList;

  void createNewInvoice(Invoice invoice) => _invoiceList.add(invoice);
}
