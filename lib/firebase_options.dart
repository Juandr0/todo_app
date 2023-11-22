// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAQed7wXvAQGh3ZFgrYAx6Hz64LM-wPemI',
    appId: '1:927024593446:web:d3cb085e5a90a13675c4e7',
    messagingSenderId: '927024593446',
    projectId: 'todoappflutter-a361f',
    authDomain: 'todoappflutter-a361f.firebaseapp.com',
    storageBucket: 'todoappflutter-a361f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD374c2TJ-ez41_rywx2AyNak3o-rMJ2yI',
    appId: '1:927024593446:android:21e15710085d4c7075c4e7',
    messagingSenderId: '927024593446',
    projectId: 'todoappflutter-a361f',
    storageBucket: 'todoappflutter-a361f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCf6NHeyky49Eq7HBKpO1pKTxmvB98u_cs',
    appId: '1:927024593446:ios:c6ae9b26cec8c41675c4e7',
    messagingSenderId: '927024593446',
    projectId: 'todoappflutter-a361f',
    storageBucket: 'todoappflutter-a361f.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCf6NHeyky49Eq7HBKpO1pKTxmvB98u_cs',
    appId: '1:927024593446:ios:906f08b139831e0d75c4e7',
    messagingSenderId: '927024593446',
    projectId: 'todoappflutter-a361f',
    storageBucket: 'todoappflutter-a361f.appspot.com',
    iosBundleId: 'com.example.todoApp.RunnerTests',
  );
}