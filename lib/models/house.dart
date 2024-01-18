import 'package:hive/hive.dart';
import 'package:kw_calculator/models/house_division.dart';

part 'house.g.dart';

@HiveType(typeId: 2)
class House extends HiveObject {
  House({
    required this.name,
    required this.address,
    this.divisions = const [],
    required this.squareMeters,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String address;

  @HiveField(2)
  List<HouseDivision> divisions;

  @HiveField(3)
  int squareMeters;

  @override
  String toString() {
    return '$name: ${address}  Num of Divisions:${divisions.length} with $squareMeters m2';
  }
}
