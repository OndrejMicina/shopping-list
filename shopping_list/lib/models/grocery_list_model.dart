import 'package:shopping_list/models/grocery_model.dart';
import 'package:hive/hive.dart';

part 'grocery_list_model.g.dart';

@HiveType(typeId: 1)
class GroceryList extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<Grocery> groceries;

  GroceryList(this.id, this.name, this.groceries);
}
