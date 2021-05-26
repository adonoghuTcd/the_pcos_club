import 'package:flutter/material.dart';

abstract class AuthService {

  Future<void> signInWithGoogle({required BuildContext context});
  // Future<User> signInWithApple();
  Future<void> signOut({required BuildContext context});
  // Stream<User> get onAuthStateChanged;
}