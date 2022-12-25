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
    apiKey: 'AIzaSyBlZ6pK1yd6l5bltt4BHnsP0XHnmzpIOxo',
    appId: '1:94989424274:web:d5dc84391b6a08e0b9784b',
    messagingSenderId: '94989424274',
    projectId: 'myday-95947',
    authDomain: 'myday-95947.firebaseapp.com',
    storageBucket: 'myday-95947.appspot.com',
    measurementId: 'G-V2J7YMS82M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmkM1NNKd-feNeHSpkj198O4otHk12OWY',
    appId: '1:94989424274:android:a5b66a2db78af99eb9784b',
    messagingSenderId: '94989424274',
    projectId: 'myday-95947',
    storageBucket: 'myday-95947.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAC05zKsSQ2U0W090blgn-aKXpr5dwgD7w',
    appId: '1:94989424274:ios:afc86917ddaa8fddb9784b',
    messagingSenderId: '94989424274',
    projectId: 'myday-95947',
    storageBucket: 'myday-95947.appspot.com',
    iosClientId: '94989424274-k5jq3rpedts4khhhhf3rn1mrnn7pb71i.apps.googleusercontent.com',
    iosBundleId: 'com.example.uasd',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAC05zKsSQ2U0W090blgn-aKXpr5dwgD7w',
    appId: '1:94989424274:ios:afc86917ddaa8fddb9784b',
    messagingSenderId: '94989424274',
    projectId: 'myday-95947',
    storageBucket: 'myday-95947.appspot.com',
    iosClientId: '94989424274-k5jq3rpedts4khhhhf3rn1mrnn7pb71i.apps.googleusercontent.com',
    iosBundleId: 'com.example.uasd',
  );
}
