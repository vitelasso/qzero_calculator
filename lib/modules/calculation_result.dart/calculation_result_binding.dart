import 'package:get/get.dart';
import 'package:kw_calculator/modules/calculation_result.dart/calculation_result_controller.dart';

class CalculatorResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalculationResultController>(
      () => CalculationResultController(),
    );
  }
}
