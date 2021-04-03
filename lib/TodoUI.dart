import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Database.dart';

class TodoAppUI extends StatefulWidget {
  @override
  _TodoAppUIState createState() => _TodoAppUIState();
}

class _TodoAppUIState extends State<TodoAppUI> {
  // ========================================= //
  final dbHelper = DatabaseHelper.instance;
  final textEditingController = TextEditingController();
  bool validated = true;
  String errorTxt = "";
  String todoEdited = "";
  var myItems = List();
  List<Widget> childrenList = new List<Widget>();

  void addTodo() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: todoEdited,
    };
    final id = await dbHelper.insert(row);
    print(id);
    Navigator.pop(context);
    todoEdited = "";
    setState(() {
      validated = true;
      errorTxt = "";
    });
  }

  Future<bool> query() async {
    myItems = [];
    childrenList = [];
    var allRows = await dbHelper.queryAll();
    allRows.forEach((row) {
      myItems.add(row.toString());
      childrenList.add(
        Card(
          elevation: 7.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: ListTile(
              title: Text(
                row['todo'],
                style: TextStyle(fontSize: 18.0, fontFamily: 'Raleway'),
              ),
              onLongPress: () {
                // TODO Delete Data
                dbHelper.deleteData(row['id']);
                setState(() {});
              },
            ),
          ),
        ),
      );
    });
    return Future.value(true);
  }

  // ========================================= //
  //TODO Create AlertDialogBox Function
  void showAlertDialog() {
    textEditingController.text = "";
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Text('Add Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: textEditingController,
                    onChanged: (_val) {
                      todoEdited = _val;
                    },
                    autofocus: true,
                    style: TextStyle(fontSize: 18.0, fontFamily: 'Raleway'),
                    decoration: InputDecoration(
                      errorText: validated ? null : errorTxt,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          if (textEditingController.text.isEmpty) {
                            setState(() {
                              errorTxt = "Can't Be Empty";
                              validated = false;
                            });
                          } else if (textEditingController.text.length > 512) {
                            setState(() {
                              errorTxt = "Too may Characters";
                              validated = false;
                            });
                          } else {
                            addTodo();
                          }
                        },
                        color: Colors.purple,
                        child: Text(
                          'ADD',
                          style:
                              TextStyle(fontSize: 18.0, fontFamily: 'Raleway'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //TODO Create Card
  // Widget myCard(String task) {
  //   return Card(
  //     elevation: 7.0,
  //     margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
  //     child: Container(
  //       padding: EdgeInsets.all(5.0),
  //       child: ListTile(
  //         title: Text(
  //           '$task',
  //           style: TextStyle(fontSize: 18.0, fontFamily: 'Raleway'),
  //         ),
  //         onLongPress: () {
  //           print('Should get deleted');
  //         },
  //       ),
  //     ),
  //   );
  // }

  // ========================================= //
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData == null) {
          return Center(child: Text('NO DATA'));
        } else {
          if (myItems.length == 0) {
            return Scaffold(
              backgroundColor: Colors.black,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.purple,
                onPressed: showAlertDialog,
                child: Icon(Icons.add, color: Colors.white),
              ),
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'My Tasks',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
                ),
              ),
              body: Center(
                child: Text(
                  "No Task Avaliable",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 20.0),
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.black,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.purple,
                onPressed: showAlertDialog,
                child: Icon(Icons.add, color: Colors.white),
              ),
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'My Tasks',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: childrenList,
                ),
              ),
            );
          }
        }
      },
      future: query(),
    );
  }
}
