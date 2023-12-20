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
    apiKey: 'AIzaSyAouyxBgbGgntIjOFdbYrGIn2rYuEGGjc8',
    appId: '1:982572736525:web:b0c8b5d6cfce5e01fd3544',
    messagingSenderId: '982572736525',
    projectId: 'social-media-app-29487',
    authDomain: 'social-media-app-29487.firebaseapp.com',
    storageBucket: 'social-media-app-29487.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqH6rZFCuiv4eTnST6S-hgATCzffZxn1k',
    appId: '1:982572736525:android:b342f6defa02a567fd3544',
    messagingSenderId: '982572736525',
    projectId: 'social-media-app-29487',
    storageBucket: 'social-media-app-29487.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC08KsnPFC_KPAMo8y8d0O3-WtQYh68gIM',
    appId: '1:982572736525:ios:bbf2480291e75b75fd3544',
    messagingSenderId: '982572736525',
    projectId: 'social-media-app-29487',
    storageBucket: 'social-media-app-29487.appspot.com',
    iosClientId: '982572736525-9iiks0n54stlp3fo5mnpju51365pfvt7.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialMedia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC08KsnPFC_KPAMo8y8d0O3-WtQYh68gIM',
    appId: '1:982572736525:ios:b346c750e2593bd3fd3544',
    messagingSenderId: '982572736525',
    projectId: 'social-media-app-29487',
    storageBucket: 'social-media-app-29487.appspot.com',
    iosClientId: '982572736525-66ju3keq7qa23vtm6tv53e2gdheumhis.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialMedia.RunnerTests',
  );
}
