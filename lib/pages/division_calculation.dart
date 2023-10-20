import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kw_calculator/controllers/calculation_result_controller.dart';
import 'package:kw_calculator/controllers/division_calculation_controller.dart';
import 'dart:ui' as ui;

class KwCalc extends GetView<DivisionCalculationController> {
  KwCalc({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  _newDivisionCalculation() {
    // go to kwCalc
    Get.toNamed('/kwCalc');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kw Calculator"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'Division Width (in m2)',
                    decoration: const InputDecoration(
                        labelText: 'Division Width (in m2)'),
                    initialValue: '5',
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'Division Height (in m2)',
                    decoration: const InputDecoration(
                        labelText: 'Division Height (in m2)'),
                    initialValue: '3',
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () async {
                      ui.Image? result = await controller.calculateDivisionKW();
                      final calculationResultController =
                          Get.find<CalculationResultController>();
                      calculationResultController.updateResultImage(result);
                      calculationResultController.updateTotalAmountOfFilms(
                          controller.totalAmountOfFilms.value.round());
                      calculationResultController
                          .updateTotalArea(controller.totalArea.value);
                      Get.toNamed('/calculationResult');
                    },
                    child: const Text('Calculate Result'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
