import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Text(
            "User ID: kll2962",
            style: TextStyle(fontSize: 18.0),
          ),
          Row(
            children: [
              Text(
                "Email:Khan@gmail.com",
                style: TextStyle(fontSize: 18.0),
              ),
              TextButton(onPressed: () => {}, child: Text("Veify Email"))
            ],
          ),
          Text(
            "Created:11/11/2024",
            style: TextStyle(fontSize: 18.0),
          )
        ],
      ),
    );
  }
}
