import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socially/model/task.dart';

Future<String> addTask(title, overview) async {
  try {
    User user = FirebaseAuth.instance.currentUser;
    Firestore.instance.collection('tasks').document().setData({
      'title': title,
      'overview': overview,
      'status': 'pending',
      'userId': user.uid
    });
    return 'Task created successfully!';
  } catch(e) {
    return 'Something went wrong!';
  }
}

Future<List<Task>> getUpcomingTasks() async {
  try {
    await Firestore.instance.collection('tasks').getDocuments().then((val) {
      if(val.documents.length > 0){
        print(val.documents);
      }
      else{
        print("Not Found");
      }
    });
  } catch(e) {}
}