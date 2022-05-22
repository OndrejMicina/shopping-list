import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shopping_list/dialogs/add_grocery_dialog.dart';
import 'package:shopping_list/grocery_list_tile_view.dart';
import 'package:shopping_list/models/grocery_model.dart';
import 'dialogs/create_new_list_dialog.dart';
import 'models/grocery_list_model.dart';
import 'package:nanoid/nanoid.dart';

class DetailPage extends StatefulWidget {
  final GroceryList groceryList;
  const DetailPage({Key? key, required this.groceryList}) : super(key: key);

  List<Grocery> getGroceries() {
    GroceryList grocList = Hive.box('userLists').get(groceryList.id);
    return grocList.groceries;
  }

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late List<Grocery> gList = widget.getGroceries();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void _addGrocery() {
      showDialog(
          context: context,
          builder: (context) {
            return AddGroceryDialog(
              addNewGrocery: (value) {
                widget.groceryList.groceries.add(value);
                widget.groceryList.save();
                setState(() {
                  gList = widget.getGroceries();
                });
              },
            );
          });
    }

    void popOut() {
      Navigator.of(context).pop();
    }

    void onItemTapped(int index) {
      if (index == 1) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Buy groceries'),
            content: const Text('List will be deleted!'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => {
                  Navigator.pop(context, 'OK'),
                  popOut(),
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('List removed')))
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        setState(() {
          _selectedIndex = index;
        });
      } else {}
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.groceryList.name),
      ),
      body: ListView.builder(
          itemCount: gList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(gList[index].groceryName),
              subtitle: Text(gList[index].ammount.toString()),
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //vytvaranie listu
          //var glist = GroceryList('147', 'Peter', 0, <Grocery>[]);
          //_deleteAtIndex(0);
          _addGrocery();
        },
        tooltip: 'Add new item',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedIconTheme: IconThemeData(size: 35),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'My lists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_checkout),
            label: 'Buy',
          ),
        ],
        currentIndex: _selectedIndex, //New

        onTap: onItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
