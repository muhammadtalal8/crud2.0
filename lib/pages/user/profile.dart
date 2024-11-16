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
    if (user != null && !user.emailVerified) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Text(
            "User ID: $uid",
            style: TextStyle(fontSize: 18.0),
          ),
          Row(
            children: [
              Text(
                "Email: $email",
                style: TextStyle(fontSize: 18.0),
              ),
              TextButton(
                  onPressed: () => {verifyEmail()},
                  child: const Text("Veify Email"))
            ],
          ),
          Text(
            "Created: $creationTime",
            style: TextStyle(fontSize: 18.0),
          )
        ],
      ),
    );
  }
}
