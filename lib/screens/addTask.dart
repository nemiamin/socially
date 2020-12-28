import 'package:flutter/material.dart';
import 'package:socially/firestore/task.dart';
import 'package:socially/screens/taskScreen.dart';

class AddTask extends StatefulWidget {

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController overviewController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  showMessage(String msg) {
    final SnackBar snackBar =
    SnackBar(content: Text(msg));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  validateForm() {
    if(titleController.text.isEmpty) {
      showMessage('Title is required!');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF311f4f),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
          ),
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
                        )
                      ],
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Task Title",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: titleController,
                      style: TextStyle(color: Colors.white),
                      decoration: new InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          hintText: "Task title",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Task Overview",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: overviewController,
                      maxLines: 5,
                      style: TextStyle(color: Colors.white),
                      decoration: new InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          hintText: "Task Overview",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if(titleController.text.isNotEmpty) {
                          String addTaskResponse = await addTask(titleController.text, overviewController.text);
                          showMessage(addTaskResponse);
                          print(addTaskResponse);
                          if(addTaskResponse == 'Task created successfully!') {
                            Navigator.pop(context);
                          }
                        } else {
                          validateForm();
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
