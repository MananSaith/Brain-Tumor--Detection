// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCOdlj8R6TNqfz-7XPfsyzk0vNXBExUShs',
    appId: '1:225480888681:web:6fd8236e2a26a6d71a6df8',
    messagingSenderId: '225480888681',
    projectId: 'brain-tumor-91861',
    authDomain: 'brain-tumor-91861.firebaseapp.com',
    storageBucket: 'brain-tumor-91861.firebasestorage.app',
    measurementId: 'G-FYB3NRKHB5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAUmQhmPVeg71v875wxBXYXNQdCS5kHfbE',
    appId: '1:225480888681:android:062bbeb2ce150e101a6df8',
    messagingSenderId: '225480888681',
    projectId: 'brain-tumor-91861',
    storageBucket: 'brain-tumor-91861.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAz-kOJhuQ21KSYx3licqVV5WarvjB5-jA',
    appId: '1:225480888681:ios:e6347d49eb5438e41a6df8',
    messagingSenderId: '225480888681',
    projectId: 'brain-tumor-91861',
    storageBucket: 'brain-tumor-91861.firebasestorage.app',
    iosBundleId: 'com.example.brainTumor',
  );
}
