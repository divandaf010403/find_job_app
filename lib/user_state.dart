import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Jobs/jobs_screen.dart';
import 'LoginPage/login_screen.dart';

class UserState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.data == null) {
          print('User Is Not Logged In Yet');
          return Login();

        } else if (userSnapshot.hasData) {
          print('User Is Already Loggen In');
          return JobScreen();

        } else if (userSnapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('An Error Has Been Occured, Try Again Later'),
            ),
          );

        } else if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: Text('Something Went Wrong'),
          ),
        );
      },
    );
  }
}
