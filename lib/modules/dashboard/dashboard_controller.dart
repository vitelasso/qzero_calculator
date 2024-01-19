import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:kw_calculator/models/house.dart';

class DashboardController extends GetxController {
  final RxList<House> housesList = (List<House>.of([])).obs;

  late Box box;

  void fetchHouses() {
    housesList.clear();
    housesList.addAll((box.values as Iterable<House>).toList());
  }

  @override
  void onReady() async {
    super.onReady();
    box = Hive.box<House>("hive_box");
    fetchHouses();
  }

  String calculateFilmsAmount(House house) {
    int filmsAmount = 0;
    for (var division in house.divisions) {
      filmsAmount += division.filmsAmount.toInt();
    }
    return filmsAmount.toString();
  }

  String calculateKwAmount(House house) {
    double kwAmount = 0;
    for (var division in house.divisions) {
      kwAmount += division.kwAmount;
    }
    return kwAmount.toString();
  }

  void addHouse(String name, String address, int squareMeters) {
    House dataModel = House(
      name: name,
      address: address,
      squareMeters: squareMeters,
    );

    if (box.containsKey(dataModel.key)) {
      box.delete(dataModel.key);
    }

    box.add(dataModel);
    fetchHouses();
    update();
  }

  void editHouse(House house, String name, String address, int squareMeters) {
    house.name = name;
    house.address = address;
    house.squareMeters = squareMeters;
    house.save();
    fetchHouses();
    update();
  }

  void removeHouse(House house) {
    house.delete();
    fetchHouses();
    update();
  }
}
