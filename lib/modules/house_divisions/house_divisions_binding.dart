import 'package:get/get.dart';
import 'package:kw_calculator/modules/house_divisions/house_divisions_controller.dart';

class HouseDivisionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HouseDivisionsController>(
      () => HouseDivisionsController(),
    );
  }
}
