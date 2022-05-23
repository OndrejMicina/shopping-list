import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shopping_list/dialogs/join_list_dialog.dart';
import 'package:shopping_list/grocery_list_tile_view.dart';
import 'package:shopping_list/models/grocery_model.dart';
import 'dialogs/create_new_list_dialog.dart';
import 'models/grocery_list_model.dart';
import 'package:nanoid/nanoid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GroceryList> userGroceryLists =
      Hive.box('userLists').values.toList().cast<GroceryList>();
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    userGroceryLists =
        Hive.box('userLists').values.toList().cast<GroceryList>();

    void _appendToList(GroceryList groceryList) {
      setState(() {
        //userGroceryLists.add(groceryList);
        Hive.box('userLists').put(groceryList.id, groceryList);
      });
    }

    void _deleteAtIndex(int index) {
      setState(() {
        Hive.box('userLists').deleteAt(index);
      });
    }

    void onItemTapped(int index) {
      if (index == 0) {
        showDialog(
            context: context,
            builder: (context) {
              return NewGroceryListDialog(
                createList: (value) {
                  _appendToList(value);
                },
              );
            });
        setState(() {
          _selectedIndex = index;
        });
      } else {
        {
          showDialog(
              context: context,
              builder: (context) {
                return JoinListListDialog(
                  createList: (value) {
                    _appendToList(value);
                  },
                );
              });
          setState(() {
            _selectedIndex = index;
          });
        }
      }
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _appendToList method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: userGroceryLists.length,
        itemBuilder: (context, index) {
          final item = GroceryListTile(
            groceryListObject: userGroceryLists[index],
          );
          return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(userGroceryLists[index].id),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                _deleteAtIndex(index);

                var name = userGroceryLists[index].name;

                // Then show a snackbar.
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$name removed')));
              },
              background: Container(color: Colors.red),
              child: item);
        },
      ),

      /*ListView.builder(
          itemCount: userGroceryLists.length,
          itemBuilder: (context, index) {
            return GroceryListTile(
              groceryListObject: userGroceryLists[index],
            );
          }),*/

      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          //vytvaranie listu
          //var glist = GroceryList('147', 'Peter', 0, <Grocery>[]);
          _deleteAtIndex(0);
          //_appendToList(glist);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        selectedIconTheme: IconThemeData(size: 35),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: 'Create new list',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Join list',
          ),
        ],
        currentIndex: _selectedIndex, //New

        onTap: onItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
