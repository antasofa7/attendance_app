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
    apiKey: 'AIzaSyCiuNPhZNMlG-uJRUZlvIxCzP0ZFoiDqB4',
    appId: '1:357897641656:web:ca0474b633696729121e4d',
    messagingSenderId: '357897641656',
    projectId: 'attendance-app-8afe5',
    authDomain: 'attendance-app-8afe5.firebaseapp.com',
    storageBucket: 'attendance-app-8afe5.appspot.com',
    measurementId: 'G-51QHTK9H9H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_eV5D-vM5KcZAAC4ogWIH4REQS10Jm3M',
    appId: '1:357897641656:android:8a443b3a1f517035121e4d',
    messagingSenderId: '357897641656',
    projectId: 'attendance-app-8afe5',
    storageBucket: 'attendance-app-8afe5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0sUi3QufxYdZcxha6-eJjn_i3zlijQKc',
    appId: '1:357897641656:ios:9fadc1bd72ee5792121e4d',
    messagingSenderId: '357897641656',
    projectId: 'attendance-app-8afe5',
    storageBucket: 'attendance-app-8afe5.appspot.com',
    iosBundleId: 'com.example.attendanceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0sUi3QufxYdZcxha6-eJjn_i3zlijQKc',
    appId: '1:357897641656:ios:073a5a9edbeb42bb121e4d',
    messagingSenderId: '357897641656',
    projectId: 'attendance-app-8afe5',
    storageBucket: 'attendance-app-8afe5.appspot.com',
    iosBundleId: 'com.example.attendanceApp.RunnerTests',
  );
}
