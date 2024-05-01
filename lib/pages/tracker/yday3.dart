import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:intl/intl.dart';
class yday3screen extends StatefulWidget {
  const yday3screen({Key? key}) : super(key: key);

  @override
  State<yday3screen> createState() => _yday3screenState();
}

class _yday3screenState extends State<yday3screen> {
  DateTime yday3 = DateTime.now().subtract(Duration(days: 3));
  late Future<DocumentSnapshot> _sFuture;
  late Map <String,dynamic>st = {};
  @override
  void initState() {
    super.initState();
    _sFuture = _fetchProfile();
    
    
  }
  Future<DocumentSnapshot> _fetchProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
    }
    throw Exception('No current user');
  }

  void don4(){
    if (st.containsKey(DateFormat('yMd').format(yday3))) {
      
    } else {
      st[DateFormat('yMd').format(yday3)] = 0;

    }
    return;
  }

  Widget build(BuildContext context) {
    return SizedBox(
      width: 400, // Example max width constraint
      height: 400,
      child: Scaffold(
        body: Center(
          child: FutureBuilder<DocumentSnapshot>(
            future: _sFuture,
            builder: (context,snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
          
              final profileData = snapshot.data?.data() as Map<String, dynamic>?;
              if(profileData != null){
                st = profileData['steps'] ?? '';
              }
              if(!st.containsKey(DateFormat('yMd').format(yday3))){
                  st[DateFormat('yMd').format(yday3)] = 0;
                  final currentUser = FirebaseAuth.instance.currentUser;
                  
                  if (currentUser != null)  {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(currentUser.uid)
                        .update({'steps':st});
    }
              }
              
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text("Total Steps Taken That day: ${st[DateFormat('yMd').format(yday3)]}"),]
                );
             // Example max height constraint
            },
          ),
        ),
      )
    );
  }
}