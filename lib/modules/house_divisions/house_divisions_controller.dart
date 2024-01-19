import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:kw_calculator/models/house.dart';
import 'package:kw_calculator/models/house_division.dart';

class HouseDivisionsController extends GetxController {
  final RxList<HouseDivision> houseDivisionsList = (List<HouseDivision>.of([])).obs;

  static double filmLenght = 0.5; //remove after
  static double filmWidth = 0.25; //remove after

  late Box box;
  final Rxn<House> selectedHouse = Rxn<House>();

  void fetchHouseDivisions() {
    houseDivisionsList.clear();
    houseDivisionsList.addAll(selectedHouse.value!.divisions.toList());
  }

  @override
  void onReady() async {
    super.onReady();
    box = Hive.box<House>("hive_box");
    if (Get.arguments['house'] != null) {
      selectedHouse(Get.arguments['house']);
      fetchHouseDivisions();
    }
  }

  bool nameAlreadyExist(String name) {
    return selectedHouse.value!.divisions.any((element) => element.name == name);
  }

  void editHouseDivision(HouseDivision division, String name, double width, double height) {
    double sideToUse = height > width ? width : height;

    double sideNotToUse = height > width ? height : width;

    double amountOfLines = sideToUse / (filmLenght + 0.1);

    double amountOfFilmsByLine = (sideNotToUse - (sideNotToUse * 0.02)) / filmWidth;

    HouseDivision dataModel = HouseDivision(
      name: name,
      width: width,
      height: height,
      kwAmount: ((sideNotToUse - (sideNotToUse * 0.02)) * amountOfLines.floor() * 40),
      filmsAmount: amountOfFilmsByLine * amountOfLines.floor(),
    );
    selectedHouse.value!.divisions.removeWhere((element) => element.name == name);
    selectedHouse.value!.divisions.add(dataModel);
    selectedHouse.value!.save();
    fetchHouseDivisions();
    update();
  }

  void addHouseDivision(String name, double width, double height) {
    double sideToUse = height > width ? width : height;

    double sideNotToUse = height > width ? height : width;

    double amountOfLines = sideToUse / (filmLenght + 0.1);

    double amountOfFilmsByLine = (sideNotToUse - (sideNotToUse * 0.02)) / filmWidth;

    HouseDivision dataModel = HouseDivision(
      name: name,
      width: width,
      height: height,
      kwAmount: ((sideNotToUse - (sideNotToUse * 0.02)) * amountOfLines.floor() * 40),
      filmsAmount: amountOfFilmsByLine * amountOfLines.floor(),
    );

    selectedHouse.value!.divisions.add(dataModel);
    selectedHouse.value!.save();
    fetchHouseDivisions();
    update();
  }
}
