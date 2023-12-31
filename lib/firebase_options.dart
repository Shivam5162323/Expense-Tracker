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
    apiKey: 'AIzaSyAVHH6sNHYFPdvi901aW8nDxVboQTN7BjM',
    appId: '1:521339235788:web:0e58ba531df758330e0169',
    messagingSenderId: '521339235788',
    projectId: 'msgs-2d55c',
    authDomain: 'msgs-2d55c.firebaseapp.com',
    storageBucket: 'msgs-2d55c.appspot.com',
    measurementId: 'G-GXHVCDS1ZN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRAYf_EqaHl15y4bPqv-yCGjfhN_qfbew',
    appId: '1:521339235788:android:d8962eb624e624350e0169',
    messagingSenderId: '521339235788',
    projectId: 'msgs-2d55c',
    storageBucket: 'msgs-2d55c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBM5AnTTMK7F44RQKcTrwBtMpTq_fCo1eQ',
    appId: '1:521339235788:ios:05cd7ee9bd47f0020e0169',
    messagingSenderId: '521339235788',
    projectId: 'msgs-2d55c',
    storageBucket: 'msgs-2d55c.appspot.com',
    iosBundleId: 'com.example.exp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBM5AnTTMK7F44RQKcTrwBtMpTq_fCo1eQ',
    appId: '1:521339235788:ios:8dcc62070c01946b0e0169',
    messagingSenderId: '521339235788',
    projectId: 'msgs-2d55c',
    storageBucket: 'msgs-2d55c.appspot.com',
    iosBundleId: 'com.example.exp.RunnerTests',
  );
}
