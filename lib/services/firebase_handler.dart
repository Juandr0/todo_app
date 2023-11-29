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
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  Future<String?> _uploadImage(File image, String imageName) async {
    try {
      final Reference storageRef = _storage.ref().child('images/$imageName');
      final UploadTask uploadTask = storageRef.putFile(image);

      // Await the completion of the upload task
      await uploadTask;

      // Get the download URL after the upload task is complete
      final imageUrl = await storageRef.getDownloadURL();
      log(imageUrl);
      return imageUrl;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  void saveTodo(Todo todo) async {
    String uid = _getUserId();
    log('Userid: $uid');

    if (todo.image?.path != null) {
      log(todo.image!.path);
      File imageFile = File(todo.image!.path);
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      log(imageName);
      String? imageUrl = await _uploadImage(imageFile, imageName);
      log(imageUrl!);

      // ignore: unnecessary_null_comparison
      if (imageUrl != null) {
        // Handle the uploaded image URL (e.g., save it to Firestore)
        log('Image uploaded successfully. URL: $imageUrl');
        todo.imageUrl = imageUrl; // Save the image URL in your Todo model
      } else {
        // Handle the case where image upload fails
        log('Image upload failed.');
      }
    }

    final data = {
      'title': todo.title,
      'description': todo.description,
      'done': todo.done,
      'backgroundColor': todo.backgroundColor.value,
      'imageUrl': todo.imageUrl,
      'image': todo.image,
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

  void signInAndSetup() async {
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
          image: data['image'],
          imageUrl: data['imageUrl'],
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

  void disposeListener() async {
    _todosController.close();
  }
}
