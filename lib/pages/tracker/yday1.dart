import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:intl/intl.dart';
class yday1screen extends StatefulWidget {
  const yday1screen({Key? key}) : super(key: key);

  @override
  State<yday1screen> createState() => _yday1screenState();
}

class _yday1screenState extends State<yday1screen> {
  DateTime yday1 = DateTime.now().subtract(Duration(days: 1));
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
    if (st.containsKey(DateFormat('yMd').format(yday1))) {
      
    } else {
      st[DateFormat('yMd').format(yday1)] = 0;

    }
    return;
  }

  Widget build(BuildContext context) {
    return SizedBox(
      width: 400, // Example max width constraint
      height: 200,
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
              if(!st.containsKey(DateFormat('yMd').format(yday1))){
                  st[DateFormat('yMd').format(yday1)] = 0;
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
                children: [Text("Total Steps Taken That day: ${st[DateFormat('yMd').format(yday1)]}"),]
                );
             // Example max height constraint
            },
          ),
        ),
      )
    );
  }
}