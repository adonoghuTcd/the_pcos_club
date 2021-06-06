import 'package:flutter/material.dart';

abstract class AuthService {

  bool isAuthenticated();
  Future<void> signInWithGoogle();
  // Future<User> signInWithApple();
  Future<void> signOut();
  // Stream<User> get onAuthStateChanged;
}