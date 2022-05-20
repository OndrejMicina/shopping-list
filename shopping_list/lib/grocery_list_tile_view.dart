import 'package:flutter/material.dart';

class GroceryListTile extends StatelessWidget {
  final String name;

  GroceryListTile({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 80,
        color: Colors.lightGreenAccent,
        child: Text(name),
      ),
    );
  }
}
