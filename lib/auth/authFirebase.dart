import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'dart:async';

import './authService.dart';
// import '../main.dart';
import '../models/user.dart';
import '../utils/snackbar.dart';

class Authentication extends ChangeNotifier implements AuthService {
  late UserModel _userModel;

  UserModel get userModel => _userModel;

  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  bool isAuthenticated() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return true;
    }
    return false;
  }

  void _firebaseUserToUser(User user) {
    _userModel = UserModel(
        uid: user.uid,
        displayName: user.displayName ?? '',
        photoUrl: user.photoURL ?? '',
        email: user.email ?? '');
  }

  Future<void> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
        _firebaseUserToUser(user!);

        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
          _firebaseUserToUser(user!);
          notifyListeners();
        } on FirebaseAuthException catch (e) {
          throw Future.error(e.code);
        } catch (e) {
          throw Future.error(e);
        }
      }
    }
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   CustomSnackBar.customSnackBar(
      //     content: 'Error signing out. Try again.',
      //   ),
      // );
    }
  }

  // noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
