import 'package:shopping_list/models/grocery_model.dart';

class GroceryList {
  String id;
  String name;
  double elementCount;
  List<Grocery> groceries;

  GroceryList(this.id, this.name, this.elementCount, this.groceries);
}
