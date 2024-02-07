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
    apiKey: 'AIzaSyA_TzLl93gTuwA_-lUq8Lt4ebX888ul_TU',
    appId: '1:209439075973:web:2515bbaa927ea02f6883ec',
    messagingSenderId: '209439075973',
    projectId: 'test-app-eb0a9',
    authDomain: 'test-app-eb0a9.firebaseapp.com',
    storageBucket: 'test-app-eb0a9.appspot.com',
    measurementId: 'G-PVS5PEG56T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQKTNi58_530g-fgkqEvP2mSfNYiLcrj8',
    appId: '1:209439075973:android:972ae58d8817cbab6883ec',
    messagingSenderId: '209439075973',
    projectId: 'test-app-eb0a9',
    storageBucket: 'test-app-eb0a9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTO9BMrfqKGOlccmTZH5LGMN73RZXO3nc',
    appId: '1:209439075973:ios:62403c880fcdaef86883ec',
    messagingSenderId: '209439075973',
    projectId: 'test-app-eb0a9',
    storageBucket: 'test-app-eb0a9.appspot.com',
    iosClientId: '209439075973-letc9pmjhhvb99f93d1qrfrrgprjt3k0.apps.googleusercontent.com',
    iosBundleId: 'com.example.testApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDTO9BMrfqKGOlccmTZH5LGMN73RZXO3nc',
    appId: '1:209439075973:ios:4a57bdc76ab2c93c6883ec',
    messagingSenderId: '209439075973',
    projectId: 'test-app-eb0a9',
    storageBucket: 'test-app-eb0a9.appspot.com',
    iosClientId: '209439075973-bu3m6heu5anosjus2qb36g806tunrt7l.apps.googleusercontent.com',
    iosBundleId: 'com.example.testApp.RunnerTests',
  );
}