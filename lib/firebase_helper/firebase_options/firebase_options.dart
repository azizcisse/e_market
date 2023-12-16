import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:3259453791:ios:d0ac927db03fcf9661e6ea',
        apiKey: 'AIzaSyDAGjY2N3HEOqMjF8swazEH0Z8oUJ01KVc',
        projectId: 'emarket-f65f8',
        messagingSenderId: '3259453791',
        iosBundleId: 'com.example.eMarket',
        storageBucket: 'emarket-f65f8.appspot.com',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:3259453791:android:343b43b4d3ede69961e6ea',
        apiKey: 'AIzaSyC6XPsjB9EmSpjqHZoRYjWa8ij-BPxaWw8',
        projectId: 'emarket-f65f8',
        messagingSenderId: '3259453791',
        storageBucket: 'emarket-f65f8.appspot.com',
      );
    }
  }
}
