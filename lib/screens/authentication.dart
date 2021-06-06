import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colours.dart';
import '../auth/authFirebase.dart';
import '../widgets/google_sign_in_button.dart';
import '../utils/snackbar.dart';

class AuthenticationScreen extends StatefulWidget {
  // const AuthenticationPage({Key key}) : super(key: key);
  static const routeName = '/authentication';
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _isSigningIn = false;

  get onPressedHandler => this._onPressedHandler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColour.primary(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.10,
            right: MediaQuery.of(context).size.width * 0.10,
            bottom: MediaQuery.of(context).size.width * 0.08,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        'images/pcos_logo.png',
                        //height: 250,,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Wellness Tracker',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              GoogleSignInButton(
                onPressedHandler: this.onPressedHandler,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedHandler() {
    FutureBuilder(
      future: Provider.of<Authentication>(context, listen: false).signInWithGoogle(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (snapshot.error == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.customSnackBar(
                content:
                    'The account already exists with a different credential.',
              ),
            );
          } else if (snapshot.error == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.customSnackBar(
                content:
                    'Error occurred while accessing credentials. Try again.',
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.customSnackBar(
                content: 'Error occurred using Google Sign-In. Try again.',
              ),
            );
          }
          // return Text('Error initializing Firebase');
        } else if (snapshot.connectionState == ConnectionState.done) {
          return GoogleSignInButton(
            onPressedHandler: this.onPressedHandler,
          );
        }
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.white,
          ),
        );
      },
    );
  }
}
