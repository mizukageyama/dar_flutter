import 'dart:io';
import 'package:dar_flutter/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            signIn(context);
          },
          child: const Text('Google Auth'),
        ),
      ),
    ));
  }

  Future signIn(BuildContext context) async {
    const List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ];

    GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: Platform.isIOS
          ? dotenv.env['IOS_GOOGLE_CLIENT_ID']
          : dotenv.env['ANDROID_GOOGLE_CLIENT_ID'],
      scopes: scopes,
    );

    try {
      GoogleSignInAccount? googleUser =
          await googleSignIn.signInSilently() ?? await googleSignIn.signIn();

      if (googleUser == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sign in failed.')));
      } else {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        debugPrint(googleAuth.accessToken.toString());

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(googleUser: googleUser)));
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
