import 'package:firebase_auth/firebase_auth.dart';
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
    if (index == 4) { // If the Chat icon is tapped
    Navigator.pushNamed(context, '/chatbot'); // Navigate to the ChatBotScreen
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aman Swastya', style: TextStyle(color: Color.fromARGB(255, 155, 85, 229))),
        backgroundColor: Colors.black, // Set app bar background color to black
        actions: [
          IconButton(
            onPressed: () {
              void signUserOut() async {
                await FirebaseAuth.instance.signOut();
              }
              signUserOut();
            },
            icon: Icon(Icons.logout,
                color: Color.fromARGB(255, 135, 52, 225)), // Set icon color to black
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
        selectedItemColor: Color.fromARGB(255, 153, 64, 231),
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

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Page',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class FitnessTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Fitness Tracker Page',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Page',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class ChatBotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Page',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}


// class ChatBotScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Navigate to the desired page when the ChatBotScreen is built
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       Navigator.pushReplacementNamed(context, '/chatbot'); // Replace '/chatbot' with the actual route of the chatbot screen
//     });

//     // Placeholder widget until navigation occurs
//     return Scaffold(
//       body: Center(
//         child: ChatBotScreen(), // Or any other loading indicator
//       ),
//     );
//   }
// }

class Tutorials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tutorials Page',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
