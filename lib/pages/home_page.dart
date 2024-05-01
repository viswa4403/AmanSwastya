import 'package:first_app/pages/chatbot/chatbot.dart';
import 'package:first_app/pages/homepage/home.dart';
import 'package:first_app/pages/profile.dart';
import 'package:first_app/pages/tutorials/tutorials.dart';
import 'package:first_app/pages/tracker/trackerpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    Home(),
    FitnessTracker(),
    Tutorials(),
    Profile(),
    ChatBotScreen(),
  ];

  void _onItemTapped(int index) {
        setState(() {
      _selectedIndex = index;
    });
    // if (index == 4) {
    //   // If the Chat icon is tapped
    //   Navigator.pushNamed(context, '/chatbot'); // Navigate to the ChatBotScreen
    // }
  //   if (index == 4) { // If the Chat icon is tapped
  //   Navigator.pushNamed(context, '/chatbot'); 
  // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text('Aman Swastya', style: TextStyle(color: Color.fromARGB(255, 155, 85, 229))),
      //   backgroundColor: Colors.black, // Set app bar background color to black
      //   actions: [
      //     IconButton(
      //       onPressed: () async{
      //         void signUserOut() async {
      //           await FirebaseAuth.instance.signOut();
      //         }
      //         signUserOut();
      //       },
      //       icon: Icon(Icons.logout,
      //           color: Color.fromARGB(255, 135, 52, 225)), // Set icon color to black
      //     ),
      //   ],
      // ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed
        backgroundColor: Color.fromARGB(255, 5, 5, 5),
        onTap: _onItemTapped,
        selectedItemColor: Color.fromARGB(255, 231, 97, 64),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Set icon color to black
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center), // Set icon color to black
            label: 'Fitness',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection), // Set icon color to black
            label: 'Tutorials',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Set icon color to black
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat), // Set icon color to black
            label: 'Chatbot',
          ),
        ],
      ),
    );
  }
}

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Home Page',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }
// }

// class FitnessTracker extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Fitness Tracker Page',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }
// }

// class Profile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Profile Page',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }
// }

// class ChatBotScreenn extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Home Page',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }
// }

class ChatBotScreenn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFF112244), // Set a futuristic texture background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ChatBot Screen exited',
              style: TextStyle(
                  fontSize: 24,
                  color:
                      Colors.white), // Increase font size and change text color
            ),
            SizedBox(height: 40), // Increase spacing
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set button color to blue
                elevation: 5, // Add elevation
                padding: EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12), // Add padding
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Set button border radius
                ),
              ),
              child: Text(
                'Go to Home using Nav',
                style: TextStyle(
                    fontSize: 16, color: Colors.white), // Set button text style
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// class ChatBotScreenn extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF112244), // Set a futuristic texture background color
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'ChatBot Screen exited',
//               style: TextStyle(fontSize: 24, color: Colors.white), // Increase font size and change text color
//             ),
//             SizedBox(height: 40), // Increase spacing
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.popUntil(context, ModalRoute.withName('/'));
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue, // Set button color to blue
//                 elevation: 5, // Add elevation
//                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Add padding
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8), // Set button border radius
//                 ),
//               ),
//               child: Text(
//                 'Go to Home using Nav',
//                 style: TextStyle(fontSize: 16, color: Colors.white), // Set button text style
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class ChatBotScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => Home()),
//       );
//     });

//     return Center(
//       child: Text(
//         'Home Page',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }
// }

