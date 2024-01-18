import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kw_calculator/models/house_division.dart';
import 'package:kw_calculator/modules/house_divisions/house_divisions_controller.dart';

class HouseDivisionsView extends GetView<HouseDivisionsController> {
  const HouseDivisionsView({super.key});

  _newHouseDivision(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
              child: SizedBox(
                height: 300.0,
                width: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FormBuilder(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('New House Division'),
                            FormBuilderTextField(
                              name: 'name',
                              decoration: const InputDecoration(labelText: 'Name'),
                              initialValue: 'Bedroom',
                            ),
                            FormBuilderTextField(
                              name: 'width',
                              decoration: const InputDecoration(labelText: 'Width (in m)'),
                              initialValue: '4',
                              keyboardType: const TextInputType.numberWithOptions(decimal: true)
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'height',
                              decoration: const InputDecoration(labelText: 'Height (in m)'),
                              initialValue: '5',
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                            const SizedBox(height: 10),
                            MaterialButton(
                              color: Theme.of(context).colorScheme.secondary,
                              onPressed: () async {
                                controller.addHouseDivision(
                                    _formKey.currentState?.instantValue["name"].toString() ?? '',
                                    double.parse(_formKey.currentState?.instantValue["width"]),
                                    double.parse(_formKey.currentState?.instantValue["height"]));
                                Get.back();
                              },
                              child: const Text('Create House Divsion'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  _editHouseDivision(BuildContext context, HouseDivision houseDivision) {
    final _formKey = GlobalKey<FormBuilderState>();
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
              child: SizedBox(
                height: 300.0,
                width: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FormBuilder(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('Edit ${houseDivision.name} Division'),
                            FormBuilderTextField(
                              name: 'width',
                              decoration: const InputDecoration(labelText: 'Width (in m)'),
                              initialValue: houseDivision.width.toString(),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true)
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'height',
                              decoration: const InputDecoration(labelText: 'Height (in m)'),
                              initialValue: houseDivision.height.toString(),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                            const SizedBox(height: 10),
                            MaterialButton(
                              color: Theme.of(context).colorScheme.secondary,
                              onPressed: () async {
                                controller.editHouseDivision(
                                    houseDivision,
                                    houseDivision.name,
                                    double.parse(_formKey.currentState?.instantValue["width"]),
                                    double.parse(_formKey.currentState?.instantValue["height"]));
                                Get.back();
                              },
                              child: const Text('Save Changes'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('${controller.selectedHouse.value?.name} Divisions'),
        ),
        body: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: controller.houseDivisionsList.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    _editHouseDivision(context, controller.houseDivisionsList[index]);
                  },
                  child: Card(child: GridTile(header: Text('Name: ${controller.houseDivisionsList[index].name}'), footer: Text('Measures: ${controller.houseDivisionsList[index].width.toString()} m x ${controller.houseDivisionsList[index].height.toString()} m'),
                       child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               Text('Kw Amount: ${controller.houseDivisionsList[index].kwAmount.toString()}'),
                                               Text('Films Amount: ${controller.houseDivisionsList[index].filmsAmount.toString()}'),
                                             ],
                                           ),
                       )));
            }),

        floatingActionButton: FloatingActionButton(
          onPressed: () => _newHouseDivision(context),
          tooltip: 'New House Division',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
