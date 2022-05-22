import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nanoid/nanoid.dart';
import 'package:shopping_list/models/grocery_model.dart';

import '../models/grocery_list_model.dart';

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
                      GroceryList(nanoid(8), groceryListName, <Grocery>[]);

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
