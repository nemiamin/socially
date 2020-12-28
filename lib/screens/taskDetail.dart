import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socially/firestore/task.dart';
import 'package:socially/screens/taskScreen.dart';

class TaskDetailScreen extends StatefulWidget {
  String id;
  TaskDetailScreen(this.id);
  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
bool loading = false;
bool deleted = false;
TextEditingController titleController = TextEditingController();
final _scaffoldKey = GlobalKey<ScaffoldState>();

showMessage(String msg) {
  if(msg != null) {
    final SnackBar snackBar =
    SnackBar(content: Text(msg));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}


void _subTaskBottomSheet(){
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        Size size = MediaQuery.of(ctx).size;
        return SafeArea(
          child: Container(
            height: 200,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 10, bottom:10, left: 10, right:10),
                  child: Container(
                    width: double.infinity,
                    child: Text('Add Sub Task', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  )
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10, bottom:10, left: 30, right:30),
                    child: Container(
                      width: double.infinity,
                      child: TextField(
                        controller: titleController,
                        style: TextStyle(color: Colors.black),
                        decoration: new InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            hintText: "Task title",
                            hintStyle: TextStyle(color: Colors.black)),
                      ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20, bottom:10, left: 10, right:10),
                    child: Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () async {
                          String addSubTaskResponse = await addSubTask(titleController.text, this.widget.id);
                          showMessage(addSubTaskResponse);
                          print(addSubTaskResponse);
                          if(addSubTaskResponse == 'Sub Task created successfully!') {
                            titleController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: Center(
                          child: Container(
                            height: 50,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFb63bfe),
                                      Color(0xFF8c3aff),
                                    ])),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    )
                ),
              ],
            )
          ),
        );
      });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      backgroundColor: Color(0xFF311f4f),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('tasks').where(
              FieldPath.documentId,
              isEqualTo: this.widget.id
          ).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if(snapshot.hasData) {
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
                                      _subTaskBottomSheet();
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
                              snapshot.data != null ? snapshot.data.documents[0]['title'] : '',
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              "Overview",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              snapshot.data.documents[0]['overview'] == null ? snapshot.data.documents[0]['overview'] : 'No overview',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              "Progress",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),

                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              "All Tasks",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection('subtasks').where('main_task_id',isEqualTo: this.widget.id).snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if(snapshot.hasData) {
                                    if(snapshot.data.documents.length > 0) {
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data.documents.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                                            child: GestureDetector(
                                              onTap: () async {
                                                print(snapshot.data.documents[index].id);
                                                String response = await updateSubTask(snapshot.data.documents[index].id,snapshot.data.documents[index]['status'], this.widget.id);
                                              },
                                              child: snapshot.data.documents[index]['status'] == 'completed' ? Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height:20,
                                                      width: 20,
                                                      decoration: BoxDecoration(

                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.grey.shade200,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Icon(Icons.check, size:12, color: Colors.white),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex:8,
                                                    child: Text(
                                                      snapshot.data.documents[index]['title'].toString(),
                                                      style: TextStyle(
                                                          color: Colors.white, fontSize: 16, decoration: TextDecoration.lineThrough),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ],
                                              ) : Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height:20,
                                                      width: 20,
                                                      decoration: BoxDecoration(

                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.grey.shade200,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex:8,
                                                    child: Text(
                                                      snapshot.data.documents[index]['title'].toString(),
                                                      style: TextStyle(
                                                        color: Colors.white, fontSize: 16, ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return Align(
                                        alignment: Alignment.center,
                                        child: Text('No sub task at the moment', style: TextStyle(color: Colors.white),),
                                      );
                                    }
                                  } else {
                                    return Align(
                                        alignment: Alignment.center,
                                        child:Text('Loading...')
                                    );
                                  }
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Align(
                  alignment: Alignment.center,
                  child: Text('No such task found!', style: TextStyle(color:Colors.white),)
              );
            }
          })
  );
  }
}
