import 'package:get/get.dart';
import 'package:kw_calculator/controllers/calculation_result_controller.dart';
import 'package:kw_calculator/controllers/division_calculation_controller.dart';

class MainBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<DivisionCalculationController>(
        () => DivisionCalculationController(),
        fenix: true);
    Get.lazyPut<CalculationResultController>(
        () => CalculationResultController(),
        fenix: true);
  }
}
