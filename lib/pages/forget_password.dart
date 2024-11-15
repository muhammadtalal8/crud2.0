// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:crud2/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            " password Rest Email has been send!",
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          )));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong password provided by User",
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: const Text(
              'Reset Link will be sent to your email id !',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Expanded(
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            autofocus: false,
                            decoration: const InputDecoration(
                                labelText: 'Email:',
                                labelStyle: TextStyle(fontSize: 20.0),
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 15)),
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              } else if (!value.contains("@")) {
                                return 'Please Enter Valid Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 60.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        email = emailController.text;
                                      });
                                      resetPassword();
                                    }
                                  },
                                  child: const Text(
                                    'Send Email',
                                    style: TextStyle(fontSize: 18),
                                  )),
                              TextButton(
                                  onPressed: () => {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context, a, b) =>
                                                    const Signup(),
                                                transitionDuration:
                                                    const Duration(seconds: 0)),
                                            (route) => false)
                                      },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(fontSize: 14),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account"),
                              TextButton(
                                  onPressed: () => {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context, a, b) =>
                                                    const Login(),
                                                transitionDuration:
                                                    const Duration(seconds: 0)),
                                            (route) => false)
                                      },
                                  child: const Text("Signup"))
                            ],
                          ),
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
