import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kw_calculator/controllers/calculation_result_controller.dart';

class CalculationResultPage extends GetView<CalculationResultController> {
  const CalculationResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Division Result"),
      ),
      body: Center(
          child: Column(
        children: [
          Text(
              "Total amount of films needed: ${controller.totalAmountOfFilms.value.toString()}"),
          Text(
              "Total amount of KW: ${(controller.totalArea.value * 40).toString()} W"),
          SizedBox(height: 10),
          RawImage(
            image: controller.resultImage.value,
            fit: BoxFit.scaleDown,
          ),
        ],
      )),
    );
  }
}
