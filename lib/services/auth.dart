import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/to_do.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  void addToFirebase(Todo todo) async {
    String uid = _getUserId();

    //_auth.collection('test').set();
  }

  void signInAnonymously() async {
    try {
      var result = await _auth.signInAnonymously();
      //print(result);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          //print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
        //print("Unknown error.");
      }
    }
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
