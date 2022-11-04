import 'package:biil_podu_app/controllers/items_controller.dart';
import 'package:get/get.dart';

class ItemsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ItemsController(), permanent: true);
  }
}
