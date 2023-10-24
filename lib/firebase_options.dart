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
    apiKey: 'AIzaSyDkv2di_0B6k4JGlhUkJxpTALlw_BAw71w',
    appId: '1:152622669930:web:d00937cef34925c66aea13',
    messagingSenderId: '152622669930',
    projectId: 'chatapplication-4b561',
    authDomain: 'chatapplication-4b561.firebaseapp.com',
    storageBucket: 'chatapplication-4b561.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbphI-rEuoAx1WRzW6MEApIoeMOdXrhoM',
    appId: '1:152622669930:android:c452fff12f0f4dd36aea13',
    messagingSenderId: '152622669930',
    projectId: 'chatapplication-4b561',
    storageBucket: 'chatapplication-4b561.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7f5PInr_H8INnFNJNkNHMj5JpBaEu6pY',
    appId: '1:152622669930:ios:db761022e9511dc26aea13',
    messagingSenderId: '152622669930',
    projectId: 'chatapplication-4b561',
    storageBucket: 'chatapplication-4b561.appspot.com',
    androidClientId: '152622669930-jvfj2c4mc50jo42s61nr6l1cp130o64t.apps.googleusercontent.com',
    iosClientId: '152622669930-ujierfgv4r4upsri98q1gojh9dr27t6u.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7f5PInr_H8INnFNJNkNHMj5JpBaEu6pY',
    appId: '1:152622669930:ios:3c75455e1c0a8e206aea13',
    messagingSenderId: '152622669930',
    projectId: 'chatapplication-4b561',
    storageBucket: 'chatapplication-4b561.appspot.com',
    androidClientId: '152622669930-jvfj2c4mc50jo42s61nr6l1cp130o64t.apps.googleusercontent.com',
    iosClientId: '152622669930-ihucamfnq5p1tugncrnf26th0uiif5fh.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled.RunnerTests',
  );
}