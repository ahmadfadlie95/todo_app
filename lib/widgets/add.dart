import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  var toDoName = TextEditingController();
  var toDoDesc = TextEditingController();
  var place = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Page"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Please fill in the information"),
            TextField(controller: toDoName, decoration: InputDecoration(hintText: "Enter todo name")),
            TextField(controller: toDoDesc, decoration: InputDecoration(hintText: "Enter todo description")),
            TextField(controller: place, decoration: InputDecoration(hintText: "Enter place")),
            TextButton(onPressed: (){
               print(toDoName.text);
               print(toDoDesc.text);
               print(place.text);
              var newItem = {"name":toDoName.text, "place":place.text, "desc":toDoDesc.text, "completed":false};
              if(toDoName.text.isEmpty == true || toDoDesc.text.isEmpty == true || place.text.isEmpty == true) {
                const snackBar = SnackBar(
                    content: Text("All fields are required"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
               } else {
                Navigator.pop(context, newItem);
              }
            }, child: Text("Add")),
          ],
        ),
      ),
    );
  }
}

