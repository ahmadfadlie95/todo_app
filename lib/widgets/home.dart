import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:to_dos/widgets/add.dart';
import 'package:to_dos/widgets/details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List <dynamic>  _todos = [
    {
      "name": "Learn Listview",
      "place": "Online Zoom",
      "desc": "Learn Listview, builder, Listtile, icon",
      "completed": true
    },
    {
      "name": "Learn Navigation",
      "place": "Online Zoom",
      "desc": "Basic Navigation, pass forward data, pass backward data",
      "completed": true
    },
    {
      "name": "Learn Shared Preference",
      "place": "Online Zoom",
      "desc": "Save and retrieving data",
      "completed": false
    }
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  void loadData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var todostring = prefs.getString("todos");
    if(todostring != null){
      var todos = jsonDecode(todostring);
      setState(() {
        _todos = todos;
      });
    }
  }
  void saveData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Shared preference can only save in string, int, double, boolean, list of strings
    // jsonEncode is use to transform map or list into string
    prefs.setString("todos", jsonEncode(_todos));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
        actions: [
          IconButton(
              onPressed: () async {
                //if there is an await, i need to async at the nearest curly bracket function
                var newItem = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPage()),
                );
                if (newItem != null) {
                  _todos.add(newItem);
                  // Obtain shared preferences.
                  saveData();
                  setState(() {
                    _todos;
                  });
                }
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          //how many rows are there
          itemCount: _todos.length,
          //what to show on every row/index
          //for every row/index, show a container of height, 50 of color amber
          //inside it, show us centered text showing the name of item in the list at the given row
          itemBuilder: (BuildContext context, int index) {
            // return Container(
            //   height: 50,
            //   color: Colors.amber,
            //   child: Center(child: Text(_todos[index]["name"]!)),
            // );
            return Card(
              child: ListTile(
                leading: _todos[index]["completed"] == true?Icon(Icons.check):SizedBox(),
                title: Text(_todos[index]["name"]!),
                subtitle: Text(_todos[index]["place"]!),
                trailing: Icon(Icons.chevron_right),
                onTap: () async {
                  var item = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(todo: _todos[index], index: index)));
                  if (item != null) {
                    if (item["action"] == "del") {
                      _todos.removeAt(item["index"]);
                      saveData();
                      setState(() {
                        _todos;
                      });
                    }
                    else if(item["action"] == "mark"){
                      _todos[item["index"]]["completed"] = !_todos[item["index"]]["completed"];
                      saveData();
                      setState(() {
                        _todos;
                      });
                    }
                  }
                },
              ),
            );
          }),
    );
  }
}
