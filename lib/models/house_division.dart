import 'package:hive/hive.dart';

part 'house_division.g.dart';

@HiveType(typeId: 1)
class HouseDivision extends HiveObject {
  HouseDivision({
    required this.name,
    required this.width,
    required this.height,
    this.kwAmount = 0,
    this.filmsAmount = 0,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  double width;

  @HiveField(2)
  double height;

  @HiveField(3)
  double kwAmount;

  @HiveField(4)
  double filmsAmount;

  @override
  String toString() {
    return '$name: ${width}m x ${height}m  Kw:$kwAmount Films:$filmsAmount';
  }
}
