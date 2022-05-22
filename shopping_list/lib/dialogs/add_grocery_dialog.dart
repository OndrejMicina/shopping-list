import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_model.dart';

class AddGroceryDialog extends StatefulWidget {
  final Function(Grocery) addNewGrocery;

  const AddGroceryDialog({required this.addNewGrocery});

  @override
  State<AddGroceryDialog> createState() => _AddGroceryDialogState();
}

class _AddGroceryDialogState extends State<AddGroceryDialog> {
  final _formKey = GlobalKey<FormState>();

  Widget buildTextField(String hint, TextEditingController controller) {
    return Container(
        //margin: EdgeInsets.all(4),
        child: TextField(
      decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(borderSide: BorderSide())),
      controller: controller,
    ));
  }

  var listNameController = TextEditingController();
  var listAmmountController = TextEditingController();
  var listUnitController = TextEditingController();

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Container(
          padding: EdgeInsets.all(8),
          //height: 170,
          width: 380,
          child: Column(
            children: [
              Text('Add grocery',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
              buildTextField('Grocery name', listNameController),
              buildTextField('Ammount', listAmmountController),
              buildTextField('Unit', listUnitController),
              ElevatedButton(
                  onPressed: () {
                    Grocery groceryItem = Grocery(
                        listNameController.text,
                        double.parse(listAmmountController.text),
                        listUnitController.text,
                        false);
                    widget.addNewGrocery(groceryItem);
                    Navigator.of(context).pop();
                  },
                  child: Text('Add'))
            ],
          ),
        ),
      );
}
