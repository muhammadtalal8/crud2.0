// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;
  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print("Verification Email has been sent");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Verification Email has been sent",
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Text(
            "User ID: $uid",
            style: const TextStyle(fontSize: 18.0),
          ),
          Row(
            children: [
              Text(
                "Email: $email",
                style: const TextStyle(fontSize: 18.0),
              ),
              user!.emailVerified
                  ? const Text(
                      "Verified",
                      style:
                          TextStyle(fontSize: 18.0, color: Colors.blueAccent),
                    )
                  : TextButton(
                      onPressed: () => {verifyEmail()},
                      child: const Text("Veify Email"))
            ],
          ),
          Text(
            "Created: $creationTime",
            style: const TextStyle(fontSize: 18.0),
          )
        ],
      ),
    );
  }
}
