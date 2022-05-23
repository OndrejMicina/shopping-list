import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nanoid/nanoid.dart';
import 'package:shopping_list/models/grocery_model.dart';

import '../models/grocery_list_model.dart';

class JoinListListDialog extends StatefulWidget {
  final Function(GroceryList) createList;

  JoinListListDialog({required this.createList});

  @override
  State<JoinListListDialog> createState() => _JoinListDialogState();
}

class _JoinListDialogState extends State<JoinListListDialog> {
  String listID = '';

  Future<GroceryList> createGrocList({required String id}) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('groceryListObject')
        .doc(id)
        .get();

    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    var name = data['name'];
    var groceries = data['groceries'];

    List<Grocery> listOfGroc = [];
    for (var item in groceries) {
      listOfGroc
          .add(Grocery(item['name'], item['ammount'], item['unit'], false));
    }
    GroceryList glist = GroceryList(id, name, listOfGroc);

    return glist;
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Write invite code',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              NewListFormWidget(
                onChangedListName: (value) => setState(() {
                  listID = value;
                }),
                onCreateButtonPressed: () async {
                  GroceryList glist = await createGrocList(id: listID);

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
