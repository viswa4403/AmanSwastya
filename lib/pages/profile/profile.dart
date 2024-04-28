import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Color.fromARGB(255, 231, 97, 64))),
        backgroundColor: Color.fromARGB(255, 0, 0, 0), // Set app bar background color to black
        actions: [
          IconButton(
            onPressed: () async{
              void signUserOut() async {
                await FirebaseAuth.instance.signOut();
              }
              signUserOut();
            },
            icon: Icon(Icons.logout,
                color: Color.fromARGB(255, 100, 100, 100)), // Set icon color to black
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Profile Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}