// ignore_for_file: use_build_context_synchronously, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/utils.dart';
import 'package:tictactoe/views/login_view/login_view.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'A verification link has been sent to your email address.'),
            ElevatedButton(
              child: const Text('Check Email'),
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;
                await user!
                    .reload(); // Reload user data to update emailVerified property
                if (user.emailVerified) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginView(email: user.email.toString())));
                } else {
                  Utils.toastMessage('Email Not Verified!');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
