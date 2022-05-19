import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping_list/models/GroceryModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.orange),
      title: 'Shopping list',
      home: const GroceriesListScreen(),
    );
  }
}

class Groceries extends StatefulWidget {
  const Groceries({Key? key}) : super(key: key);

  @override
  State<Groceries> createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {
  List<GroceryModel> groceries = [
    GroceryModel("Carrot", 10, "Martin", false),
    GroceryModel("Milk", 1, "Martin", false),
    GroceryModel("Chips", 2, "Martin", false),
    GroceryModel("Napkins", 1, "Stefan", false),
    GroceryModel("Salt", 1, "Martin", false),
    GroceryModel("Carrot", 10, "Martin", false),
    GroceryModel("Milk", 1, "Martin", false),
    GroceryModel("Chips", 2, "Martin", false),
    GroceryModel("Napkins", 1, "Stefan", false),
    GroceryModel("Salt", 1, "Martin", false),
  ];

  List<GroceryModel> selectedGroceries = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: groceries.length,
      itemBuilder: (context, index) {
        final item = groceryItem(groceries[index], index);
        return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify widgets.
            key: Key(groceries[index].groceryName),
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                groceries.removeAt(index);
              });

              var name = groceries[index].groceryName;

              // Then show a snackbar.
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('$name removed')));
            },
            background: Container(color: Colors.red),
            child: item);
      },
    );
  }

  Widget groceryItem(GroceryModel grocery, int index) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.offline_bolt,
          color: Colors.white,
        ),
      ),
      title: Text(grocery.groceryName,
          style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(
          grocery.ammount.toString() + '    ' + 'Added by: ' + grocery.addedBy),
      trailing: grocery.isSelected
          ? const Icon(
              Icons.check_circle,
              color: Colors.orange,
            )
          : const Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          groceries[index].isSelected = !groceries[index].isSelected;
          if (groceries[index].isSelected == true) {
            selectedGroceries.add(grocery);
          } else if (groceries[index].isSelected = false) {
            selectedGroceries.removeWhere((element) =>
                element.groceryName == groceries[index].groceryName);
          }
        });
      },
    );
  }
}

class GroceriesListScreen extends StatefulWidget {
  const GroceriesListScreen({Key? key}) : super(key: key);

  @override
  State<GroceriesListScreen> createState() => _GroceriesListScreenState();
}

class _GroceriesListScreenState extends State<GroceriesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friday list'),
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 110,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                    height: 70,
                    width: 90,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Text("Martins list on friday\n$index",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    color: Colors.orange),
              ),
            ),
            const Groceries(),
          ],
        )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          //BottomNavigationBarItem(
          //  icon: Icon(Icons.menu),
          //  label: 'My lists',
          //),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Buy selected',
          ),
        ],
      ),
    );
  }
}

class HomeListsScreen extends StatefulWidget {
  const HomeListsScreen({Key? key}) : super(key: key);

  @override
  State<HomeListsScreen> createState() => _HomeListsScreenState();
}

class _HomeListsScreenState extends State<HomeListsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Card(
          color: Colors.orange,
          borderOnForeground: true,
          elevation: 10,
          //child: Column(children: []),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'My lists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add),
            label: 'Create list',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.join_full),
            label: 'Join list',
          ),
        ],
      ),
    );
  }
}
