import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'models/grocery_list_model.dart';

class GroceryListTile extends StatelessWidget {
  final GroceryList groceryListObject;

  GroceryListTile({required this.groceryListObject});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: FlutterLogo(size: 50.0),
        title: Text(groceryListObject.name),
        subtitle: Text(groceryListObject.id),
        onTap: () {
          // Navigate to the details page. If the user leaves and returns to
          // the app after it has been killed while running in the
          // background, the navigation stack is restored.
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(
                        groceryList: groceryListObject,
                      )));
        });
  }
}
