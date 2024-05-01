import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class FitnessTracker extends StatefulWidget {
  @override
  _FitnessTrackerstate createState() => _FitnessTrackerstate();
}

class _FitnessTrackerstate  extends State<FitnessTracker> {

  
  late Stream<StepCount> _stepCountStream;
  //late Stream<PedestrianStatus> _pedestrianStatusStream;
  int _steps =0;
  DateTime today = DateTime.now();
  DateTime yday2 = DateTime.now().subtract(Duration(days: 2));
  DateTime yday1 = DateTime.now().subtract(Duration(days: 1));
  DateTime yday3 = DateTime.now().subtract(Duration(days: 3));
  DateTime yday4 = DateTime.now().subtract(Duration(days: 4));
  late Future<DocumentSnapshot> _sFuture;
  late Map <String,dynamic>st = {};
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
  void onStepCount(StepCount event) async{
    
    print(event);
    setState(() {
      _steps+=1;
      
    });
    final currentUser = FirebaseAuth.instance.currentUser;
    st[DateFormat('yMd').format(today)] += _steps;
    if (currentUser != null)  {
        await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({'steps':st});
    }
  }

  // void onPedestrianStatusChanged(PedestrianStatus event) {
  //   print(event);
  //   setState(() {
  //     _status = event.status;
  //   });
  // }

  // void onPedestrianStatusError(error) {
  //   print('onPedestrianStatusError: $error');
  //   setState(() {
  //     _status = 'Pedestrian Status not available';
  //   });
  //   print(_status);
  // }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = -100;
    });
    
  }

  void don4(){
    if (st.containsKey(DateFormat('yMd').format(yday4))) {
      
    } else {
      st[DateFormat('yMd').format(yday4)] = 0;

    }
    return;
  }
  void don3(){
    if (st.containsKey(DateFormat('yMd').format(yday3))) {
      
    } else {
      st[DateFormat('yMd').format(yday3)] = 0;
      
    }
    return;
  }
  void don2(){
    if (st.containsKey(DateFormat('yMd').format(yday2))) {
      
    } else {
      st[DateFormat('yMd').format(yday2)] = 0;
      
    }
    return;
  }
  void don1(){
    if (st.containsKey(DateFormat('yMd').format(yday1))) {
      
    } else {
      st[DateFormat('yMd').format(yday1)] = 0;
      
    }
    return;
  }
  void tod(){
    print("day1");
    return;
  }
  void initPlatformState() {


    // _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    // _pedestrianStatusStream
    //     .listen(onPedestrianStatusChanged)
    //     .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        body: 
            
          Center(
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 380,
                    height: 100,
                    padding: EdgeInsets.only(left:5.0,right: 5.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220,.5),
                      borderRadius: BorderRadius.circular(17)
                    
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      ElevatedButton(
                        onPressed: don4, 
                        style: ElevatedButton.styleFrom(
                          
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.only(left: 2.0,right: 2.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                          elevation: 0
                        ),
                        child: Container(
                          width: 52,
                          height: 70,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(DateFormat('EEE').format(yday4),style: TextStyle(color: Colors.black),),
                                Text(DateFormat('d MMM').format(yday4),style: TextStyle(color: Colors.black))
                            ]),
                        )),
                      // Container(
                      //     width: 52,
                      //     height:70,
                      //     decoration: BoxDecoration(
                      //     color: Color.fromARGB(255, 255, 255, 255),
                      //     borderRadius: BorderRadius.circular(17),
                      //     boxShadow: [BoxShadow(
                      //         color: Colors.grey,
                      //         blurRadius: 5.0,
                      //       ),]
                      //     ),
                      //     child: 
                      //  ),
                       
                       ElevatedButton(
                        onPressed: don3, 
                        style: ElevatedButton.styleFrom(
                          
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.only(left: 2.0,right: 2.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                          elevation: 0
                        ),
                        child: Container(
                          width: 52,
                          height: 70,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(DateFormat('EEE').format(yday3),style: TextStyle(color: Colors.black),),
                                Text(DateFormat('d MMM').format(yday3),style: TextStyle(color: Colors.black))
                            ]),
                        )),
                      
                       ElevatedButton(
                        onPressed: don2, 
                        style: ElevatedButton.styleFrom(
                          
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.only(left: 2.0,right: 2.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                          elevation: 0
                        ),
                        child: Container(
                          width: 52,
                          height: 70,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(DateFormat('EEE').format(yday2),style: TextStyle(color: Colors.black),),
                                Text(DateFormat('d MMM').format(yday2),style: TextStyle(color: Colors.black))
                            ]),
                        ))
                        ,
                       ElevatedButton(
                        onPressed: don1, 
                        style: ElevatedButton.styleFrom(
                          
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.only(left: 2.0,right: 2.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                          elevation: 0
                        ),
                        child: Container(
                          width: 52,
                          height: 70,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(DateFormat('EEE').format(yday1),style: TextStyle(color: Colors.black),),
                                Text(DateFormat('d MMM').format(yday1),style: TextStyle(color: Colors.black))
                            ]),
                        ))
                       ,
                       ElevatedButton(
                        onPressed: don1, 
                        style: ElevatedButton.styleFrom(
                          
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.only(left: 2.0,right: 2.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                          elevation: 0
                        ),
                        child: Container(
                          width: 52,
                          height: 70,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(DateFormat('EEE').format(today),style: TextStyle(color: Colors.black),),
                                Text(DateFormat('d MMM').format(today),style: TextStyle(color: Colors.black))
                            ]),
                        ))
                       
                    ],)
                  ),
                  Text(
                    'Steps Taken',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    _steps.toString(),
                    style: TextStyle(fontSize: 60),
                  ),
                  Text(
                    'Total steps taken today : ${st[DateFormat('yMd').format(today)]}',
                    style: TextStyle(fontSize: 30),
                  ),
                  Divider(
                    height: 100,
                    thickness: 0,
                    color: Colors.white,
                  ),
                  // Text(
                  //   'Pedestrian Status',
                  //   style: TextStyle(fontSize: 30),
                  // ),
                  // Icon(
                  //   _status == 'walking'
                  //       ? Icons.directions_walk
                  //       : _status == 'stopped'
                  //           ? Icons.accessibility_new
                  //           : Icons.error,
                  //   size: 100,
                  // ),
                  // Center(
                  //   child: Text(
                  //     _status,
                  //     style: _status == 'walking' || _status == 'stopped'
                  //         ? TextStyle(fontSize: 30)
                  //         : TextStyle(fontSize: 20, color: Colors.red),
                  //   ),
                  // )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

