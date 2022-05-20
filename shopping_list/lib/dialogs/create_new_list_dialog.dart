import 'package:flutter/material.dart';

class CreateNewListDialog extends StatefulWidget {
  final Function(String) addNewName;

  const CreateNewListDialog({required this.addNewName});

  @override
  State<CreateNewListDialog> createState() => _CreateNewListDialogState();
}

class _CreateNewListDialogState extends State<CreateNewListDialog> {
  final _formKey = GlobalKey<FormState>();

  Widget buildTextField(String hint, TextEditingController controller) {
    return Container(
        margin: EdgeInsets.all(4),
        child: TextField(
          decoration: InputDecoration(
              labelText: hint,
              border: OutlineInputBorder(borderSide: BorderSide())),
          controller: controller,
        ));
  }

  var listNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 170,
      width: 380,
      child: Column(
        children: [
          Text('Create new list',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
          buildTextField('List name', listNameController),
          ElevatedButton(
              onPressed: () {
                final nameOfList = listNameController.text;
                widget.addNewName(nameOfList);
                Navigator.of(context).pop();
              },
              child: Text('Create'))
        ],
      ),
    );
  }
}
