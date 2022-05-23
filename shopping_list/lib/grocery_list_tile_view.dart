import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'models/grocery_list_model.dart';

class GroceryListTile extends StatelessWidget {
  final GroceryList groceryListObject;

  GroceryListTile({required this.groceryListObject});

  Future<void> createGrocList({required GroceryList glist}) async {
    final docGroceryList = FirebaseFirestore.instance
        .collection('groceryListObject')
        .doc(glist.id);

    final json = {
      "groceries": glist.groceries
          .map((g) =>
              {"name": g.groceryName, "ammount": g.ammount, "unit": g.unit})
          .toList(),
      "id": glist.id,
      "name": glist.name
    };

    await docGroceryList.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: FlutterLogo(size: 50.0),
        title: Text(groceryListObject.name),
        subtitle: Column(children: <Widget>[
          FlatButton(
              onPressed: () {
                createGrocList(glist: groceryListObject);
                showCode(context, groceryListObject.id);
              },
              child: Text("Share"))
        ]),
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

  void showCode(var context, String id) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Share CODE'),
        content: Text(id),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
