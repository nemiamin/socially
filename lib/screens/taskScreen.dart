import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socially/firestore/authentication.dart';
import 'package:socially/firestore/task.dart';
import 'package:socially/model/task.dart';
import 'package:socially/screens/addTask.dart';
import 'package:socially/screens/taskDetail.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool loading = true;
  String name = '';
  int ongoingTasks = 0;

  Future<void> initState() {
    super.initState();
    loadUser();
    loadUpcomingTasks();
  }

  loadUpcomingTasks() async {
    List<Task> task = await getUpcomingTasks();
    print(task);
  }

  loadUser() async {
    User user = await getUser();
    if(user != null) {
      setState(() {
        name = user.displayName;
        loading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF311f4f),
      body: loading ? Align(
        alignment: Alignment.center,
        child: Text('Loading...')
      ) : SingleChildScrollView(
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
                        Icon(
                          Icons.supervised_user_circle,
                          size: 40,
                          color: Colors.white,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddTask()));
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white),
                            child: Center(
                              child: Icon(Icons.add),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Hello",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Text(
                      name,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
    StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance
        .collection('tasks').where('status',isEqualTo: 'inprogress').where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      return Text(
        "Ongoing Tasks (${snapshot.data.documents.length})",
        style: TextStyle(color: Colors.white, fontSize: 15),
      );
    }),
                    SizedBox(
                      height: 20,
                    ),
                      StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance
        .collection('tasks').where('status',isEqualTo: 'inprogress').where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if(snapshot.hasData) {

        if(snapshot.data.documents.length > 0) {

          return Container(
            height: 140,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    width: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF8c3aff),
                          Color(0xFFb63bfe),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                snapshot.data.documents[index]['title'].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15),
                              ),
                            ),
                            Icon(
                              Icons.more_vert,
                              size: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          snapshot.data.documents[index]['overview'].toString(),
                          style: TextStyle(
                              color: Colors.white, fontSize: 12),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //progress bar
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Align(
            alignment: Alignment.center,
            child: Text('No ongoing task at the moment', style: TextStyle(color: Colors.white),),
          );
        }
      } else {
        return Align(
          alignment: Alignment.center,
          child: Text('Loading....'),
        );
      }
    }),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Upcoming Tasks",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('tasks').limit(5).where('status',isEqualTo: 'pending').where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid).snapshots(),
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
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GestureDetector(
                  onTap: (){
                    print(snapshot.data.documents[index].id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskDetailScreen(snapshot.data.documents[index].id)));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF8c3aff),
                          Color(0xFFb63bfe),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.sanitizer,
                        size: 50,
                      ),
                      title: Container(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data.documents[index]['title'].toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapshot.data.documents[index]['overview'].toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      trailing: Text(
                        "Dec 16",
                        style: TextStyle(
                            color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Align(
            alignment: Alignment.center,
            child: Text('No upcoming task at the moment', style: TextStyle(color: Colors.white),),
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
      ),
    );
  }
}
