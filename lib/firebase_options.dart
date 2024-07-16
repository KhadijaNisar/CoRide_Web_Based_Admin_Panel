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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAifh4qT_8TBoKwvuNDjD_muBbSsBBJLnA',
    appId: '1:333028725651:web:d8c7a59b539ae3c3d34e66',
    messagingSenderId: '333028725651',
    projectId: 'coride-167b1',
    authDomain: 'coride-167b1.firebaseapp.com',
    storageBucket: 'coride-167b1.appspot.com',
    measurementId: 'G-EFXD9T5YER',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAifh4qT_8TBoKwvuNDjD_muBbSsBBJLnA',
    appId: '1:333028725651:web:e0265d838af2b53ed34e66',
    messagingSenderId: '333028725651',
    projectId: 'coride-167b1',
    authDomain: 'coride-167b1.firebaseapp.com',
    storageBucket: 'coride-167b1.appspot.com',
    measurementId: 'G-5MKBTRYT5Q',
  );

}