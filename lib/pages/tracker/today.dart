import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class todayscreen extends StatefulWidget {
  @override
  State<todayscreen> createState() => _todayscreenState();
}

class _todayscreenState extends State<todayscreen> {
  late Stream<StepCount> _stepCountStream;
  //late Stream<PedestrianStatus> _pedestrianStatusStream;
  int _steps = 0;
  DateTime today = DateTime.now();

  late Future<DocumentSnapshot> _sFuture;
  late Map<String, dynamic> st = {};
  //String _status ='?';
  @override
  void initState() {
    super.initState();
    _sFuture = _fetchProfile();
    initPlatformState();
  }
  // get docIDs

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

  void onStepCount(StepCount event) async {
    print(event);
    setState(() {
      _steps += 1;
    });
    final currentUser = FirebaseAuth.instance.currentUser;
    st[DateFormat('yMd').format(today)] += _steps;
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({'steps': st});
    }
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = -100;
    });
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: 400, // Example max width constraint
            height: 200,
            child: Scaffold(
              body: Center(
                child: FutureBuilder<DocumentSnapshot>(
                    future: _sFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      final profileData =
                          snapshot.data?.data() as Map<String, dynamic>?;
                      if (profileData != null) {
                        st = profileData['steps'] ?? '';
                      }
                      if (!st.containsKey(DateFormat('yMd').format(today))) {
                        st[DateFormat('yMd').format(today)] = 0;
                        final currentUser = FirebaseAuth.instance.currentUser;

                        if (currentUser != null) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(currentUser.uid)
                              .update({'steps': st});
                        }
                      }
                      return Column(children: [
                        Text(
                          'Steps Taken: ${st[DateFormat('yMd').format(today)]}',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 32.0),
                        Text(
                          'Current Steps',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          _steps.toString(),
                          style: TextStyle(fontSize: 25),
                        ),
                      ]);
                    }),
              ),
            )),
        SizedBox(
            width: 400, // Example max width constraint
            height: 200,
            child: Scaffold(
              body: Center(
                child: FutureBuilder<DocumentSnapshot>(
                    future: _sFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      final profileData =
                          snapshot.data?.data() as Map<String, dynamic>?;
                      if (profileData != null) {
                        st = profileData['steps'] ?? '';
                      }
                      if (!st.containsKey(DateFormat('yMd').format(today))) {
                        st[DateFormat('yMd').format(today)] = 0;
                        final currentUser = FirebaseAuth.instance.currentUser;

                        if (currentUser != null) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(currentUser.uid)
                              .update({'steps': st});
                        }
                      }
                      int steps = st[DateFormat('yMd').format(today)];
                      double percent_real = steps / 10000;
                      double percent = (percent_real > 1) ? 1 : percent_real;
                      return CircularPercentIndicator(
                        radius: 100.0,
                        lineWidth: 20,
                        percent: percent,
                        progressColor: Colors.deepPurple,
                        backgroundColor: Colors.deepPurple.shade100,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          "${(percent_real * 100).round()}%",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      );
                    }),
              ),
            )),
      ],
    );
  }
}
