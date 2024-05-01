import 'package:first_app/pages/homepage/ActivityCard.dart';
import 'package:first_app/pages/homepage/chart.dart';
import 'package:flutter/material.dart';
//import 'package:first_app/pages/tracker/graph.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Aman Swastya',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 30, fontStyle: 
                )
                ),
              background: Image.network(
                'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Today’s Activities', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ),
          SliverToBoxAdapter(
            child: FitnessChart(),  // Add your chart widget here
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ActivityCard(index: index);
              },
              childCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
