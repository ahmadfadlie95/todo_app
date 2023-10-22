import 'package:flutter/material.dart';
import 'package:to_dos/widgets/add.dart';
import 'package:to_dos/widgets/details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _todos = [
    {
      "name":"Learn Listview",
      "place":"Online Zoom",
      "desc":"Learn Listview, builder, Listtile, icon"
    },
    {
      "name":"Learn Navigation",
      "place":"Online Zoom",
      "desc":"Basic Navigation, pass forward data, pass backward data"
    },
    {
      "name":"Learn Shared Preference",
      "place":"Online Zoom",
      "desc":"Save and retrieving data"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Homepage"), actions: [IconButton(onPressed: ()async{
        //if there is an await, i need to async at the nearest curly bracket function
        var newItem = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddPage()),
        );
        if(newItem != null){
          _todos.add(newItem);
          setState(() {
            _todos;
          });
        }
      }, icon: Icon(Icons.add))],),
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
              child: ListTile(title: Text(_todos[index]["name"]!), subtitle: Text(_todos[index]["place"]!), trailing: Icon(Icons.chevron_right), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsPage(todo: _todos[index],)));
              },),
            );
          }
      ),
    );
  }
}
