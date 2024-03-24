// // File generated by FlutterFire CLI.
// // ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
// import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
// import 'package:flutter/foundation.dart'
//     show defaultTargetPlatform, kIsWeb, TargetPlatform;

// /// Default [FirebaseOptions] for use with your Firebase apps.
// ///
// /// Example:
// /// ```dart
// /// import 'firebase_options.dart';
// /// // ...
// /// await Firebase.initializeApp(
// ///   options: DefaultFirebaseOptions.currentPlatform,
// /// );
// /// ```
// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       return web;
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return android;
//       case TargetPlatform.iOS:
//         return ios;
//       case TargetPlatform.macOS:
//         return macos;
//       case TargetPlatform.windows:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for windows - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.linux:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for linux - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }

//   static const FirebaseOptions web = FirebaseOptions(
//     apiKey: 'AIzaSyA-Ul5jKeiYbVS7QBtr6vmCK2rGNavpTZY',
//     appId: '1:1014921345330:web:e01571c6602683a4207f2b',
//     messagingSenderId: '1014921345330',
//     projectId: 'music-player-866a3',
//     authDomain: 'music-player-866a3.firebaseapp.com',
//     storageBucket: 'music-player-866a3.appspot.com',
//     measurementId: 'G-W3JY34MSHW',
//   );

//   static const FirebaseOptions android = FirebaseOptions(
//     apiKey: 'AIzaSyA00NFSM4Gnf4ZOmSa-HMYRadR-v2IrUiY',
//     appId: '1:1014921345330:android:dd606a3c78821177207f2b',
//     messagingSenderId: '1014921345330',
//     projectId: 'music-player-866a3',
//     storageBucket: 'music-player-866a3.appspot.com',
//   );

//   static const FirebaseOptions ios = FirebaseOptions(
//     apiKey: 'AIzaSyAvFsL3CRxkqgCzN1a9Co0dvaxIg_r_QvY',
//     appId: '1:1014921345330:ios:df4d9bdda5c20648207f2b',
//     messagingSenderId: '1014921345330',
//     projectId: 'music-player-866a3',
//     storageBucket: 'music-player-866a3.appspot.com',
//     iosBundleId: 'com.example.musicPlayer',
//   );

//   static const FirebaseOptions macos = FirebaseOptions(
//     apiKey: 'AIzaSyAvFsL3CRxkqgCzN1a9Co0dvaxIg_r_QvY',
//     appId: '1:1014921345330:ios:c68d61e1cf375d57207f2b',
//     messagingSenderId: '1014921345330',
//     projectId: 'music-player-866a3',
//     storageBucket: 'music-player-866a3.appspot.com',
//     iosBundleId: 'com.example.musicPlayer.RunnerTests',
//   );
// }