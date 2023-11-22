import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/to_do.dart';

class FirebaseHandler {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  final _todosController = StreamController<List<Todo>>.broadcast();
  Stream<List<Todo>> get todoStream => _todosController.stream;

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

    final data = {
      'title': todo.title,
      'description': todo.description,
      'done': todo.done,
      'backgroundColor': todo.backgroundColor.value
    };

    if (todo.documentId != null) {
      db
          .collection('users')
          .doc(uid)
          .collection('todos')
          .doc(todo.documentId)
          .update(data);
    } else {
      db.collection('users').doc(uid).collection('todos').add(data);
    }
  }

  void signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        default:
          print("Error: $e");
      }
    }
  }

  void setupTodoListener() async {
    final uId = _getUserId();

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
        );
      }).toList();

      _todosController.add(todos);
    });
  }

  String _getUserId() {
    if (_auth.currentUser != null) {
      return _auth.currentUser!.uid;
    } else {
      //print('Error: not signed in');
      return '';
    }
  }
}
