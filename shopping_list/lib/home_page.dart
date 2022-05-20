import 'package:flutter/material.dart';
import 'package:shopping_list/grocery_list_tile_view.dart';
import 'package:shopping_list/models/grocery_model.dart';
import 'dialogs/create_new_list_dialog.dart';
import 'models/grocery_list_model.dart';

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
  List<GroceryList> userGroceryLists = [];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    void _appendToList(groceryList) {
      setState(() {
        userGroceryLists.add(groceryList);
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
          itemCount: userGroceryLists.length,
          itemBuilder: (context, index) {
            return GroceryListTile(
              name: userGroceryLists[index].name,
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //vytvaranie listu
          var glist = new GroceryList('147', 'Peter', 0, <Grocery>[]);
          _appendToList(glist);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
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

class NewGroceryListDialog extends StatefulWidget {
  final Function(GroceryList) createList;

  NewGroceryListDialog({required this.createList});

  @override
  State<NewGroceryListDialog> createState() => _NewGroceryListDialogState();
}

class _NewGroceryListDialogState extends State<NewGroceryListDialog> {
  String groceryListName = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create new grocery list',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              NewListFormWidget(
                onChangedListName: (value) => setState(() {
                  groceryListName = value;
                }),
                onCreateButtonPressed: () {
                  var glist =
                      new GroceryList('147', groceryListName, 0, <Grocery>[]);

                  widget.createList(glist);
                  Navigator.of(context).pop();
                },
              ),
            ]),
      );
}

class NewListFormWidget extends StatelessWidget {
  final String listName;
  final ValueChanged<String> onChangedListName;
  final VoidCallback onCreateButtonPressed;

  const NewListFormWidget(
      {Key? key,
      this.listName = '',
      required this.onChangedListName,
      required this.onCreateButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildListName(),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildListName() => TextFormField(
        initialValue: listName,
        onChanged: onChangedListName,
        validator: (listName) {
          if (listName!.isEmpty) {
            return 'The list name cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
            border: UnderlineInputBorder(), labelText: 'List name'),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onCreateButtonPressed, child: Text('Create')),
      );
}
