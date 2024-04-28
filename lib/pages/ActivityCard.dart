import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final int index;

  ActivityCard({required this.index});

  @override
  Widget build(BuildContext context) {
    List<String> activities = ['Yoga', 'Running', 'Cycling', 'Gym'];
    List<String> images = [
      'https://images.unsplash.com/photo-1575052814086-f385e2e2ad1b?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',
      'https://images.unsplash.com/photo-1483728642387-6c3bdd6c93e5?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',
      'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',
      'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',
    ];

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            images[index],
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
            alignment: Alignment.center,
            child: Text(
              activities[index],
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
