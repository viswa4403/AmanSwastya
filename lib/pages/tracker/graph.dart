// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:async';
// import 'package:intl/intl.dart';
// import 'package:fl_chart/fl_chart.dart';
// class graph extends StatefulWidget {
  

//   @override
//   State<graph> createState() => _graphState();
// }

// class _graphState extends State<graph> {
//   late Future<DocumentSnapshot> _sFuture;
//   DateTime today = DateTime.now();
//   DateTime yday2 = DateTime.now().subtract(Duration(days: 2));
//   DateTime yday1 = DateTime.now().subtract(Duration(days: 1));
//   DateTime yday3 = DateTime.now().subtract(Duration(days: 3));
//   DateTime yday4 = DateTime.now().subtract(Duration(days: 4));
//   late Map <String,dynamic>st = {};
  
//   @override
//   void initState() {
//     super.initState();
//     _sFuture = _fetchProfile();
//     // initPlatformState();
    
//   }
  
//   Future<DocumentSnapshot> _fetchProfile() async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       return FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUser.uid)
//           .get();
//     }
//     throw Exception('No current user');
//   }
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 400,
//       height: 300,
//       child: Scaffold(
//         body:Center(
//           child: FutureBuilder<DocumentSnapshot>(
//           future: _sFuture,
//           builder: (context,snapshot){
//             // if (snapshot.connectionState == ConnectionState.waiting) {
//             //       return Center(child: CircularProgressIndicator());
//             //   }
//             //   if (snapshot.hasError) {
//             //     print("ERROR");
//             //     return Center(child: Text('Error: ${snapshot.error}'));
//             //   }
          
//               final profileData = snapshot.data?.data() as Map<String, dynamic>?;
//               if(profileData != null){
//                 st = profileData['steps'] ?? '';
//                 // print(st);
//               }
//               if(!st.containsKey(DateFormat('yMd').format(today))){
//                   st[DateFormat('yMd').format(today)] = 0;
//                   final currentUser = FirebaseAuth.instance.currentUser;
//                   print("2");
//                   if (currentUser != null)  {
//                     FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(currentUser.uid)
//                         .update({'steps':st});};
                        
//                   }
//               if(!st.containsKey(DateFormat('yMd').format(yday1))){
//                   st[DateFormat('yMd').format(yday1)] = 0;
//                   final currentUser = FirebaseAuth.instance.currentUser;
//                   print("2");
//                   if (currentUser != null)  {
//                     FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(currentUser.uid)
//                         .update({'steps':st});};
//                         print("1");
//                   }

//               if(!st.containsKey(DateFormat('yMd').format(yday2))){
//                   st[DateFormat('yMd').format(yday2)] = 0;
//                   final currentUser = FirebaseAuth.instance.currentUser;
//                   print("2");
//                   if (currentUser != null)  {
//                     FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(currentUser.uid)
//                         .update({'steps':st});};
//                         print("1");
//                   }
//               if(!st.containsKey(DateFormat('yMd').format(yday3))){
//                   st[DateFormat('yMd').format(yday3)] = 0;
//                   final currentUser = FirebaseAuth.instance.currentUser;
//                   print("2");
//                   if (currentUser != null)  {
//                     FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(currentUser.uid)
//                         .update({'steps':st});};
//                         print("1");
//                   }
//               if(!st.containsKey(DateFormat('yMd').format(yday4))){
//                   st[DateFormat('yMd').format(yday4)] = 0;
//                   final currentUser = FirebaseAuth.instance.currentUser;
//                   print("2");
//                   if (currentUser != null)  {
//                     FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(currentUser.uid)
//                         .update({'steps':st});};
//                         print("1");
//                   }
              
              
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                     LineChart(
//                            LineChartData(
//                               minX:0,
//                               maxX:5,
//                               minY:0,
//                               maxY:3000,
//                               titlesData: FlTitlesData(
//                                   show: true,
//                                   bottomTitles: AxisTitles(
//                                     sideTitles: SideTitles(
//                                       showTitles: true,
//                                       reservedSize: 30,
//                                       getTitlesWidget: (value, meta) {
//                                         const titles = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//                                         Widget text = Text(titles[value.toInt()], style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 12));
//                                         return SideTitleWidget(
//                                           axisSide: meta.axisSide,
//                                           space: 8.0,
//                                           child: text,
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   leftTitles: AxisTitles(
//                                     sideTitles: SideTitles(
//                                       showTitles: true,
                                      
//                                       reservedSize: 40,
//                                     ),
//                                   ),
//                                 ),
//                               gridData: FlGridData(
//                                     show: true,
//                                     getDrawingHorizontalLine: (value){
//                                         return FlLine(
//                                             color: const Color.fromARGB(255, 59, 57, 57),
//                                             strokeWidth: 1
//                                         );
//                                      },
//                               ),
//                               borderData: FlBorderData(
//                                     show: false,
                                    
//                               ),
//                               lineBarsData: [
//                                   LineChartBarData(
//                                     spots: [
//                                         FlSpot(1.0, st[DateFormat('yMd').format(yday4)]),
//                                         FlSpot(2.0, st[DateFormat('yMd').format(yday3)]),
//                                         FlSpot(3.0, st[DateFormat('yMd').format(yday2)]),
//                                         FlSpot(4.0, st[DateFormat('yMd').format(yday1)]),
//                                         FlSpot(5.0, st[DateFormat('yMd').format(today)]),
//                                       ],
//                                     isCurved: true,
//                                     color: Colors.pink,
//                                     barWidth: 3,
//                                     belowBarData: BarAreaData(
//                                       gradient: LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 196, 9, 193).withOpacity(0.5),
//                                             Color.fromARGB(255, 255, 110, 233).withOpacity(0.0),
//                                           ],
//                                           begin: Alignment.topCenter,
//                                           end: Alignment.bottomCenter,
//                                     )

//                                   )
//                            )],                     // control how the chart looks
//                             ),
                            
//                     ) ,
//                 ],
//               );
//     }
             
//          ),
//        )
//       ),q
//     );
//   }
// }

      
   