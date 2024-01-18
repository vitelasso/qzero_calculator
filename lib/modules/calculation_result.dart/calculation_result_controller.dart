import 'package:get/get.dart';
import 'dart:ui' as ui;

class CalculationResultController extends GetxController {
  final Rxn<ui.Image> resultImage = Rxn<ui.Image>();

  final totalAmountOfFilms = 0.obs;

  final totalArea = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    print(Get.arguments['width']);
    print(Get.arguments['height']);
  }

  void updateResultImage(ui.Image? name) {
    resultImage(name);
  }

  void updateTotalAmountOfFilms(int name) {
    totalAmountOfFilms(name);
  }

  void updateTotalArea(double name) {
    totalArea(name);
    update();
  }
}
