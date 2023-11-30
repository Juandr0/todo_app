import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_app/models/to_do.dart';

class FirebaseHandler {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  final _todosController = StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> get todoStream => _todosController.stream;

  Future<String> uploadImage(File imageFile) async {
    String uid = _getUserId();
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/$uid/todos/images/$imageName.jpg');

    UploadTask uploadTask = storageReference.putFile(imageFile);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  void deleteTodo(Todo todo) async {
    String uid = _getUserId();
    db
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(todo.documentId)
        .delete();
  }

  void saveTodo(Todo todo) async {
    String uid = _getUserId();
    log('uid: $uid');

    if (todo.image != null && todo.image is File) {
      try {
        String imageUrl = await uploadImage(todo.image as File);
        todo.imageUrl = imageUrl;

        final data = {
          'title': todo.title,
          'description': todo.description,
          'done': todo.done,
          'backgroundColor': todo.backgroundColor.value,
          'imageurl': todo.imageUrl,
        };

        log('in try!!!!!');
        if (todo.documentId != null) {
          db
              .collection('users')
              .doc(uid)
              .collection('todos')
              .doc(todo.documentId)
              .update(data);
          log('Updated !!!!!! $uid');
        } else {
          db.collection('users').doc(uid).collection('todos').add(data);
          log('Added Data to Firebase!!!!!! ${todo.documentId}');
        }
      } catch (e, _) {
        print('''!!!!!!!!!!!!!!!!!!!
            $e
                    !!!!!!!!!!!!!!!!!!!!!!!!!!
          ''');
      }
    }
  }

  void signInAndSetup() async {
    log('SignInAndSetup!!!!!');
    await signInAnonymously();
    setupTodoListener();
  }

  Future signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }
  }

  void setupTodoListener() async {
    final uId = _getUserId();
    log('setuTodoListener: $uId');

    try {
      db
          .collection("users")
          .doc(uId)
          .collection('todos')
          .snapshots()
          .listen((QuerySnapshot snapshot) {
        List<Todo> todos = snapshot.docs.map((DocumentSnapshot doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Todo(
              documentId: doc.id,
              title: data['title'],
              description: data['description'],
              done: data['done'],
              backgroundColor: Color((data['backgroundColor'])),
              imageUrl: data['imageurl'],
              image: data['image']);
        }).toList();

        _todosController.add(todos);
        log('Snapshotlistener!!!!! ');
      });
    } catch (e, stackTrace) {
      log('Error in setupTodoListener: $e');
      log(stackTrace.toString());
    }
  }

  String _getUserId() {
    if (_auth.currentUser != null) {
      return _auth.currentUser!.uid;
    } else {
      log('Error: not signed in');
      return '';
    }
  }

  void disposeListener() async {
    _todosController.close();
  }
}
