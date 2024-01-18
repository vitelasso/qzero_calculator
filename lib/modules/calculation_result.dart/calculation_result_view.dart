import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kw_calculator/modules/calculation_result.dart/calculation_result_controller.dart';

class CalculationResultView extends GetView<CalculationResultController> {
  const CalculationResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Division Result"),
        ),
        body: Center(
            child: Column(
          children: [
            Text("Total amount of films needed: ${controller.totalAmountOfFilms.value.toString()}"),
            Text("Total amount of KW: ${(controller.totalArea.value * 40).toStringAsFixed(2)} W"),
            SizedBox(height: 10),
            /*RawImage(
              image: controller.resultImage.value,
              fit: BoxFit.scaleDown,
            ),*/
          ],
        )),
      ),
    );
  }
}
