import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:first_app/pages/tracker/today.dart';
import 'package:first_app/pages/tracker/yday4.dart';
import 'package:first_app/pages/tracker/yday3.dart';
import 'package:first_app/pages/tracker/yday2.dart';
import 'package:first_app/pages/tracker/yday1.dart';
//import 'package:first_app/pages/tracker/graph.dart';


class FitnessTracker extends StatefulWidget {
  @override
  _FitnessTrackerstate createState() => _FitnessTrackerstate();
}

class _FitnessTrackerstate  extends State<FitnessTracker> {
  int _selectedIndex = 4;

  List<Widget> _pages = [
   yday4screen(),
   yday3screen(),
   yday2screen(),
   yday1screen(),
   todayscreen()
  ];
  
  
  //late Stream<PedestrianStatus> _pedestrianStatusStream;
  
  DateTime today = DateTime.now();
  DateTime yday2 = DateTime.now().subtract(Duration(days: 2));
  DateTime yday1 = DateTime.now().subtract(Duration(days: 1));
  DateTime yday3 = DateTime.now().subtract(Duration(days: 3));
  DateTime yday4 = DateTime.now().subtract(Duration(days: 4));
  // late Future<DocumentSnapshot> _sFuture;
  // late Map <String,dynamic>st = {};

  //String _status ='?';
  
  @override
  void initState() {
    super.initState();
    // _sFuture = _fetchProfile();
    // initPlatformState();
    
  }
  // get docIDs
  
  // Future<DocumentSnapshot> _fetchProfile() async {
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser != null) {
  //     return FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(currentUser.uid)
  //         .get();
  //   }
  //   throw Exception('No current user');
  // }
  // void onStepCount(StepCount event) async{
    
  //   print(event);
  //   setState(() {
  //     _steps+=1;
      
  //   });
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //   st[DateFormat('yMd').format(today)] += _steps;
  //   if (currentUser != null)  {
  //       await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(currentUser.uid)
  //         .update({'steps':st});
  //   }
  // }

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

  // void onStepCountError(error) {
  //   print('onStepCountError: $error');
  //   setState(() {
  //     _steps = -100;
  //   });
    
  // }

  void don4(){
    setState(() {
      _selectedIndex = 0;
    });
  }
  void don3(){
    setState(() {
      _selectedIndex = 1;
    });
  }
  void don2(){
   setState(() {
      _selectedIndex = 2;
    });
  }
  void don1(){
    setState(() {
      _selectedIndex = 3;
    });
  }
  void tod(){
    setState(() {
      _selectedIndex = 4;
    });
  }
  // void initPlatformState() {


  //   // _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
  //   // _pedestrianStatusStream
  //   //     .listen(onPedestrianStatusChanged)
  //   //     .onError(onPedestrianStatusError);

  //   _stepCountStream = Pedometer.stepCountStream;
  //   _stepCountStream.listen(onStepCount).onError(onStepCountError);

  //   if (!mounted) return;
  // }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 12.0),
        // ),
        title: const Text(
          'Tracker',
          style: TextStyle(color: Color.fromARGB(255, 231, 97, 64)),
        ),
      ),
        body: SingleChildScrollView(
              
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
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
                            onPressed: tod, 
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
                      SizedBox(
                        height: 40,
                      ),
                      _pages[_selectedIndex],
                      
                      
                    ],
                  ),
              ),
            )
            
          ),
        );
      
    
  }
}


