import 'package:hive/hive.dart';

part 'grocery_model.g.dart';

@HiveType(typeId: 2)
class Grocery extends HiveObject {
  @HiveField(0)
  String groceryName;
  @HiveField(1)
  double ammount;
  @HiveField(2)
  String unit;
  @HiveField(3)
  bool isSelected;

  Grocery(this.groceryName, this.ammount, this.unit, this.isSelected);
}
