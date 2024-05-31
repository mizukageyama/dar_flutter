import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.googleUser});

  final GoogleSignInAccount googleUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(googleUser.photoUrl!),
            maxRadius: 40,
          ),
          const SizedBox(height: 10),
          Text(googleUser.displayName!),
          Text(googleUser.email),
        ],
      ),
    )));
  }
}
