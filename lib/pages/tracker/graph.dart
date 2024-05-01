import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
class graph extends StatefulWidget {
  const graph({super.key});

  @override
  State<graph> createState() => _graphState();
}

class _graphState extends State<graph> {
  late Future<DocumentSnapshot> _gFuture;
  DateTime today = DateTime.now();
  DateTime yday2 = DateTime.now().subtract(Duration(days: 2));
  DateTime yday1 = DateTime.now().subtract(Duration(days: 1));
  DateTime yday3 = DateTime.now().subtract(Duration(days: 3));
  DateTime yday4 = DateTime.now().subtract(Duration(days: 4));
  late Map <String,dynamic>gt = {};
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];
  @override
  void initState() {
    super.initState();
    _gFuture = _fetchProfile();
    // initPlatformState();
    
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
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: Scaffold(
        body:Center(child: FutureBuilder<DocumentSnapshot>(
          future: _gFuture,
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
          
              final profileData = snapshot.data?.data() as Map<String, dynamic>?;
              if(profileData != null){
                gt = profileData['steps'] ?? '';
              }
              if(!gt.containsKey(DateFormat('yMd').format(today))){
                  gt[DateFormat('yMd').format(today)] = 0;
                  final currentUser = FirebaseAuth.instance.currentUser;
                  
                  if (currentUser != null)  {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(currentUser.uid)
                        .update({'steps':gt});};
                  }
              
              
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    LineChart(
                           LineChartData(
                              minX:0,
                              maxX:5,
                              minY:0,
                              maxY:3000,
                              titlesData: Titles.getData(),
                              gridData: FlGridData(
                                    show: true,
                                    getDrawingHorizontalLine: (value){
                                        return FlLine(
                                            color: Colors.grey[800],
                                            strokeWidth: 1
                                        );
                                     },
                              ),
                              borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(color: Colors.grey[800], width: 2)
                              ),
                              lineBarsData: [
                                  LineChartBarData(
                                    spots: [
                                      FlSpot(1,gt[DateFormat('yMd').format(yday4)]),
                                      FlSpot(2,gt[DateFormat('yMd').format(yday3)]),
                                      FlSpot(3,gt[DateFormat('yMd').format(yday2)]),
                                      FlSpot(4,gt[DateFormat('yMd').format(yday1)]),
                                      FlSpot(5,gt[DateFormat('yMd').format(today)]),
                                      
                                    ],
                                    isCurved: true,
                                    colors: gradiantColors,
                                    barWidth: 3,
                                    belowBarData: BarAreaData(
                                      show: true,
                                      colors: gradiantColors.map((color) => color.withOpacity(.4)).toList()
                                    )

                                  )
                                ]                 // control how the chart looks
                                  ),
                            swapAnimationDuration: Duration(milliseconds: 150), // Optional
                            swapAnimationCurve: Curves.linear, // Optional
                    ) ,
                ],
              );
    }
             
         ),
       )
      ),
    );
  }
}
class Titles{
  DateTime today = DateTime.now();
  DateTime yday2 = DateTime.now().subtract(Duration(days: 2));
  DateTime yday1 = DateTime.now().subtract(Duration(days: 1));
  DateTime yday3 = DateTime.now().subtract(Duration(days: 3));
  DateTime yday4 = DateTime.now().subtract(Duration(days: 4));
  getTitleData() => FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      reservedSize: 35,
      getTextStyles: (value) => const TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      getTitles: (value) {
        switch (value.toInt()){
          case 1:
            return DateFormat('MMM d').format(yday4);
          case 2:
            return DateFormat('MMM d').format(yday3);
          case 3:
            return DateFormat('MMM d').format(yday2);
          case 4:
            return DateFormat('MMM d').format(yday1);
          case 5:
            return DateFormat('MMM d').format(today);
  }
  return '';
  },
      
    ),
    
      
    );
  
}