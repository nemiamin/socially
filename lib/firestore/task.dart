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
      'userId': user.uid,
      'date': new DateTime.now()
    });
    return 'Task created successfully!';
  } catch(e) {
    return 'Something went wrong!';
  }
}

Future<String> delete_task(id) async {
  try {
    await Firestore.instance.collection('tasks').doc(id).delete().then((val) {
      return 'Task deleted successfully!';
    });
    return 'Task deleted successfully!';
  } catch(e) {
    return 'Something went wrong!';
  }
}

Future<String> addSubTask(title, main_task_id) async {
  try {
    User user = FirebaseAuth.instance.currentUser;
    Firestore.instance.collection('subtasks').document().setData({
      'title': title,
      'main_task_id': main_task_id,
      'status': 'pending',
      'userId': user.uid,
      'date': new DateTime.now()
    });
    return 'Sub Task created successfully!';
  } catch(e) {
    return 'Something went wrong!';
  }
}

Future<String> updateSubTask(id, currentStatus) async {
  try {
    await Firestore.instance
        .collection('subtasks')
        .doc(id)
        .updateData({
      'status': currentStatus == 'pending' ? 'completed' : 'pending'
    });
    return 'Sub Task updated successfully!';
  } catch(e) {
    return 'Something went wrong!';
  }
}