import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  // 1) Create a property/variable to store passed item
  final Map<String,dynamic> todo;

  final int index;

  // 2) Create the constructor of the class to receive the item
  DetailsPage({required this.todo, required this.index});

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
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [ElevatedButton(onPressed: (){
                Navigator.pop(context,{"index":index, "action":"mark"});
              }, child: todo["completed"] ? Text("Unmark Completion"):Text("Mark as Completed")),
                ElevatedButton(onPressed: (){
                  showDialog(context: context, builder: (context){
                  return AlertDialog(

                  )
                  // print("Delete ditekan untuk item index $index");
                  // Navigator.pop(context, {"index":index, "action":"del"});
                }, child: Text("Delete Item"))],)
          ],
        ),
      ),
    );
  }
}