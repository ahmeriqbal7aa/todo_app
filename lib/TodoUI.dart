import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoAppUI extends StatefulWidget {
  @override
  _TodoAppUIState createState() => _TodoAppUIState();
}

class _TodoAppUIState extends State<TodoAppUI> {
  // ========================================= //
  //TODO Create AlertDialogBox Function
  void showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Text('Add Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              style: TextStyle(fontSize: 18.0, fontFamily: 'Raleway'),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {},
                  color: Colors.purple,
                  child: Text(
                    'ADD',
                    style: TextStyle(fontSize: 18.0, fontFamily: 'Raleway'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  //TODO Create Card
  Widget myCard(String task) {
    return Card(
      elevation: 7.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
          title: Text(
            '$task',
            style: TextStyle(fontSize: 18.0, fontFamily: 'Raleway'),
          ),
          onLongPress: () {
            print('Should get deleted');
          },
        ),
      ),
    );
  }

  // ========================================= //
  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            myCard('Record a Video'),
            myCard('Go to Sleep'),
            myCard('Record SQFlite Video\nInsert\nUpdate\nDelete\nQuery'),
            myCard('Buy Grocries\nApple\nMilk\nRice\nMushroom\nCorn'),
            myCard('Buy following Books\nBiology\nPhysics\nChemistry\nMath'),
            myCard('Buy following Animals\nCat\nRabbit')
          ],
        ),
      ),
    );
  }
}
