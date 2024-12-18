// ignore_for_file: sort_child_properties_last, use_build_context_synchronously

import 'package:crud2/pages/forget_password.dart';
import 'package:crud2/pages/user/change_password.dart';
import 'package:crud2/pages/user/dashboard.dart';
import 'package:crud2/pages/user/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserMain extends StatefulWidget {
  const UserMain({super.key});

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectedIndex = 0;
  static List<Widget> widgetOption = <Widget>[
    const Dashboard(),
    const Profile(),
    const ChangePassword(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("Welcome User"),
          ElevatedButton(
            onPressed: () async => {
              await FirebaseAuth.instance.signOut(),
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (route) => false),
            },
            child: const Text("Logout"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
          )
        ]),
      ),
      body: _UserMainState.widgetOption.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'My profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Change Password',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
