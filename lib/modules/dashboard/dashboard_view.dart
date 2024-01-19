import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kw_calculator/models/house.dart';
import 'package:kw_calculator/modules/dashboard/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  _newDivisionCalculation(BuildContext context) {
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
                            Text('New House Project Creation'),
                            FormBuilderTextField(
                              name: 'name',
                              decoration: const InputDecoration(labelText: 'Name'),
                              initialValue: 'Test House',
                            ),
                            FormBuilderTextField(
                              name: 'address',
                              decoration: const InputDecoration(labelText: 'Address'),
                              initialValue: 'Oxford Street 34',
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'size',
                              decoration: const InputDecoration(labelText: 'Size (in m2)'),
                              initialValue: '170',
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

  _editHouse(BuildContext context, House house) {
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
                            Text('Edit ${house.name} Project'),
                            FormBuilderTextField(
                              name: 'name',
                              decoration: const InputDecoration(labelText: 'Name'),
                              initialValue: house.name,
                            ),
                            FormBuilderTextField(
                              name: 'address',
                              decoration: const InputDecoration(labelText: 'Address'),
                              initialValue: house.address,
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'size',
                              decoration: const InputDecoration(labelText: 'Size (in m2)'),
                              initialValue: house.squareMeters.toString(),
                            ),
                            MaterialButton(
                              color: Theme.of(context).colorScheme.secondary,
                              onPressed: () async {
                                controller.editHouse(
                                    house,
                                    _formKey.currentState?.instantValue["name"].toString() ?? '',
                                    _formKey.currentState?.instantValue["address"].toString() ?? '',
                                    int.parse(_formKey.currentState?.instantValue["size"]));
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

  _removeHouse(BuildContext context, House house) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed: () => Get.back(),
      );
      Widget continueButton = TextButton(
        child: Text("Continue"),
        onPressed: () {
          controller.removeHouse(house);
          Get.back();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Delete House Project"),
        content: Text("Are you sure you want to delete ${house.name}?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
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
            //shrinkWrap: true,
            itemCount: controller.housesList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    Get.toNamed('/house_division', arguments: {
                      'house': controller.housesList[index],
                    })?.whenComplete(() => controller.fetchHouses());
                  },
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  tileColor: Colors.grey[200],
                  leading: IconButton(
                    onPressed: () => _editHouse(context, controller.housesList[index]),
                    icon: const Icon(Icons.edit),
                  ),
                  trailing: IconButton(
                    onPressed: () => _removeHouse(context, controller.housesList[index]),
                    icon: const Icon(Icons.delete),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Project: ${controller.housesList[index].name}'),
                      Text('Address: ${controller.housesList[index].address}'),
                      Text(
                          'Number of Divisions: ${controller.housesList[index].divisions.length.toString()} divisions'),
                      Text('Size: ${controller.housesList[index].squareMeters.toString()} m2'),
                      Text('Kw Amount: ${controller.calculateKwAmount(controller.housesList[index])}'),
                      Text('Films Amount: ${controller.calculateFilmsAmount(controller.housesList[index])}'),
                    ],
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _newDivisionCalculation(context),
          tooltip: 'New House',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
