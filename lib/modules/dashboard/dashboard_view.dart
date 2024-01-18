import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kw_calculator/modules/dashboard/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  _newDivisionCalculation(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    // go to kwCalc
    //Get.toNamed('/kwCalc');
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
                            Text('New House Project Creation'),
                            FormBuilderTextField(
                              name: 'name',
                              decoration: const InputDecoration(labelText: 'Name'),
                              initialValue: 'Test House',
                              onChanged: (value) {
                                if (value == null || value.isEmpty) return;
                                //controller.updateDivisionName(value);
                              },
                            ),
                            FormBuilderTextField(
                              name: 'address',
                              decoration: const InputDecoration(labelText: 'Address'),
                              initialValue: 'Oxford Street 34',
                              onChanged: (value) {
                                if (value == null || value.isEmpty) return;
                                //controller.updateDivisionWidth(double.parse(value!));
                              },
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'size',
                              decoration: const InputDecoration(labelText: 'Size (in m2)'),
                              initialValue: '170',
                              onChanged: (value) {
                                if (value == null || value.isEmpty) return;
                                //controller.updateDivisionHeight(double.parse(value!));
                              },
                            ),
                            const SizedBox(height: 10),
                            MaterialButton(
                              color: Theme.of(context).colorScheme.secondary,
                              onPressed: () async {
                                controller.addHouse(
                                    _formKey.currentState?.instantValue["name"].toString() ?? '',
                                    _formKey.currentState?.instantValue["address"].toString() ?? '',
                                    int.parse(_formKey.currentState?.instantValue["size"]));
                                Get.back();
                              },
                              child: const Text('Create House Project'),
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
          title: const Text("My Projects"),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.housesList.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Get.toNamed('/house_division', arguments: {'house': controller.housesList[index],})?.whenComplete(() => controller.fetchHouses());
                  },
                  child: Card(child: Column(
                    children: [
                      Text('Project: ${controller.housesList[index].name}'),
                      Text('Address: ${controller.housesList[index].address}'),
                      Text('Number of Divisions: ${controller.housesList[index].divisions.length.toString()} divisions'),
                      Text('Size: ${controller.housesList[index].squareMeters.toString()} m2'),
                      Text('Kw Amount: ${controller.calculateKwAmount(controller.housesList[index])}'),
                      Text('Films Amount: ${controller.calculateFilmsAmount(controller.housesList[index])}'),
                    ],
                  )));
            }),

        floatingActionButton: FloatingActionButton(
          onPressed: () => _newDivisionCalculation(context),
          tooltip: 'New House',
          child: const Icon(Icons.add),
        ),
        /*floatingActionButton: FloatingActionButton(
          onPressed: _newDivisionCalculation,
          tooltip: 'New Calculation',
          child: const Icon(Icons.add),
        ),*/ // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
