import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget {
  String id;
  TaskDetailScreen(this.id);
  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {


  void _modalBottomSheetMenu(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new  Icon(Icons.add),
                      title: new Text('Add Sub task'),
                      onTap: () {

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.remove),
                    title: new Text('Delete'),
                    onTap: () {

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF311f4f),
      body: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
        .collection('tasks').where(
          FieldPath.documentId,
          isEqualTo: this.widget.id
      ).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        print(snapshot.data.documents.length);
        return SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.only(top: 30.0,),
            child: Column(
                children: [
      Padding(
      padding: const EdgeInsets.symmetric(
      horizontal: 20.0,
      ),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      GestureDetector(
      onTap: () {
      Navigator.pop(context);
      },
      child: Container(
      height: 35,
      width: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white),
        child: Center(
          child: Icon(Icons.chevron_left),
        ),
      ),
    ),
    GestureDetector(
    onTap: () {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => TaskDetailScreen()));
    },
    child: GestureDetector(
      onTap: (){
        _modalBottomSheetMenu();
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white),
        child: Center(
          child: Icon(Icons.more_vert),
        ),
      ),
    ),
    )
    ],
    ),
    SizedBox(
    height: 20,
    ),
    Text(
      snapshot.data.documents[0]['title'],
    style: TextStyle(color: Colors.white, fontSize: 15),
    ),
    SizedBox(
    height: 20,
    ),
    SizedBox(
    height: 40,
    ),
    Text(
    "Overview",
    style: TextStyle(color: Colors.white, fontSize: 15),
    ),
    SizedBox(
    height: 20,
    ),
    Text(
      snapshot.data.documents[0]['overview'],
    style: TextStyle(color: Colors.white, fontSize: 15),
    ),
    SizedBox(
    height: 40,
    ),
    Text(
    "Progress",
    style: TextStyle(color: Colors.white, fontSize: 15),
    ),

        SizedBox(
          height: 40,
        ),
        Text(
          "All Tasks",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
    ],
    ),
    )
    ],
    ),
    ),
    );
  })
  );
  }
}
