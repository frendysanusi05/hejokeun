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
    apiKey: 'AIzaSyB-HT6EEt1dWSyFbnKoTbDSYLjqXX2i8W8',
    appId: '1:873650124560:web:0156f0ecd5b0f04866d795',
    messagingSenderId: '873650124560',
    projectId: 'hejokeun-backend-54597',
    authDomain: 'hejokeun-backend-54597.firebaseapp.com',
    storageBucket: 'hejokeun-backend-54597.appspot.com',
    measurementId: 'G-M8N6R19FJP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1GPYZ7CPkW-OQYCHIk6voO2d7Px-usuU',
    appId: '1:873650124560:android:d73226d643ff9bda66d795',
    messagingSenderId: '873650124560',
    projectId: 'hejokeun-backend-54597',
    storageBucket: 'hejokeun-backend-54597.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7a1Uox-GEqONzgtuCzZ1tzof3fvV3LpM',
    appId: '1:873650124560:ios:49b7f0c033c703c166d795',
    messagingSenderId: '873650124560',
    projectId: 'hejokeun-backend-54597',
    storageBucket: 'hejokeun-backend-54597.appspot.com',
    iosBundleId: 'com.example.hejokeun',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD7a1Uox-GEqONzgtuCzZ1tzof3fvV3LpM',
    appId: '1:873650124560:ios:6897eecfbaa6f96466d795',
    messagingSenderId: '873650124560',
    projectId: 'hejokeun-backend-54597',
    storageBucket: 'hejokeun-backend-54597.appspot.com',
    iosBundleId: 'com.example.hejokeun.RunnerTests',
  );
}
