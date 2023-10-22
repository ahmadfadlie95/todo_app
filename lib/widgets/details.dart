import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  // 1) Create a property/variable to store passed item
  final Map<String,String> todo;

  // 2) Create the constructor of the class to receive the item
  DetailsPage({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details Page"),),
      body: Center(
        child: Column(
          children: [
            Text(todo["name"]!),
            Text(todo["place"]!),
            Text(todo["desc"]!),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [ElevatedButton(onPressed: (){}, child: Text("Mark as Completed")), ElevatedButton(onPressed: (){}, child: Text("Delete Item"))],)
          ],
        ),
      ),
    );
  }
}
