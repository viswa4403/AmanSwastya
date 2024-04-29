// import 'package:first_app/pages/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:first_app/pages/auth_page.dart';

// class Profile extends StatefulWidget {
//   @override
//   _ProfileCreationPageState createState() => _ProfileCreationPageState();
// }

// class _ProfileCreationPageState extends State<Profile> {
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

//   String? _selectedGender;
//   late TextEditingController _nameController = TextEditingController();
//   TextEditingController _ageController = TextEditingController();
//   TextEditingController _weightController = TextEditingController();
//   TextEditingController _heightController = TextEditingController();
//   TextEditingController _dietController = TextEditingController();
//   TextEditingController _goalController = TextEditingController();

//   void _logout() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => AuthPage()),
//       (Route<dynamic> route) => false,
//     );
//   }

//   Future<void> _saveProfile() async {
//     try {
//       final currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser != null) {
//         final userData = {
//           'name': _nameController.text,
//           'age': _ageController.text,
//           'weight': _weightController.text,
//           'height': _heightController.text,
//           'gender': _selectedGender,
//           'diet': _dietController.text,
//           'goal': _goalController.text,
//         };
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(currentUser.uid)
//             .set(userData);

//         // Navigate to the home page after saving the profile
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => HomePage(),
//           ),
//         );
//       } else {
//         // Handle user not authenticated
//         print('User not authenticated');
//       }
//     } catch (error) {
//       // Handle error saving profile
//       print('Error saving profile: $error');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchProfile().then((doc) {
//       if (doc.exists) {
//         setState(() {
//           _nameController.text = doc['name'] ?? '';
//           _ageController.text = doc['age'] ?? '';
//           _weightController.text = doc['weight'] ?? '';
//           _heightController.text = doc['height'] ?? '';
//           _dietController.text = doc['diet'] ?? '';
//           _goalController.text = doc['goal'] ?? '';
//           _selectedGender = doc['gender'] ?? '';
//         });
//       }
//     });
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Creation'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               ValueListenableBuilder<TextEditingValue>(
//                 valueListenable: _nameController,
//                 builder: (context, TextEditingValue value, _) {
//                   return TextField(
//                     controller: _nameController,
//                     decoration: InputDecoration(labelText: 'Name'),
//                   );
//                 },
//               ),
//               TextField(
//                 controller: _ageController,
//                 decoration: InputDecoration(labelText: 'Age'),
//               ),
//               TextField(
//                 controller: _weightController,
//                 decoration: InputDecoration(labelText: 'Weight'),
//               ),
//               TextField(
//                 controller: _heightController,
//                 decoration: InputDecoration(labelText: 'Height'),
//               ),
//               DropdownButtonFormField<String>(
//                 decoration: InputDecoration(labelText: 'Gender'),
//                 value: _selectedGender, // Set the value to _selectedGender
//                 items: <String>['Male', 'Female'].map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (newValue) {
//                   setState(() {
//                     _selectedGender = newValue;
//                   });
//                 },
//               ),
//               TextField(
//                 controller: _dietController,
//                 decoration: InputDecoration(labelText: 'Dietary Restrictions'),
//               ),
//               TextField(
//                 controller: _goalController,
//                 decoration: InputDecoration(labelText: 'Primary Fitness Goal'),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _saveProfile,
//                 child: Text('Save'),
//               ),
//               ElevatedButton(
//                 onPressed: _logout,
//                 child: Text('Logout'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:first_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/pages/auth_page.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileCreationPageState createState() => _ProfileCreationPageState();
}

class _ProfileCreationPageState extends State<Profile> {
  late Future<DocumentSnapshot> _profileFuture;
  String? _selectedGender;
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _dietController;
  late TextEditingController _goalController;

  @override
  void initState() {
    super.initState();
    _profileFuture = _fetchProfile();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
    _dietController = TextEditingController();
    _goalController = TextEditingController();
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

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => AuthPage()),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _saveProfile() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userData = {
          'name': _nameController.text,
          'age': _ageController.text,
          'weight': _weightController.text,
          'height': _heightController.text,
          'gender': _selectedGender,
          'diet': _dietController.text,
          'goal': _goalController.text,
        };
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .set(userData);

        // Navigate to the home page after saving the profile
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        // Handle user not authenticated
        print('User not authenticated');
      }
    } catch (error) {
      // Handle error saving profile
      print('Error saving profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Creation'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final profileData = snapshot.data?.data() as Map<String, dynamic>?;

          if (profileData != null) {
            _nameController.text = profileData['name'] ?? '';
            _ageController.text = profileData['age'] ?? '';
            _weightController.text = profileData['weight'] ?? '';
            _heightController.text = profileData['height'] ?? '';
            _dietController.text = profileData['diet'] ?? '';
            _goalController.text = profileData['goal'] ?? '';
            _selectedGender = profileData['gender'] ?? '';
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                ),
                TextField(
                  controller: _weightController,
                  decoration: InputDecoration(labelText: 'Weight'),
                ),
                TextField(
                  controller: _heightController,
                  decoration: InputDecoration(labelText: 'Height'),
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Gender'),
                  value: _selectedGender,
                  items: <String>['Male', 'Female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                ),
                TextField(
                  controller: _dietController,
                  decoration:
                      InputDecoration(labelText: 'Dietary Restrictions'),
                ),
                TextField(
                  controller: _goalController,
                  decoration:
                      InputDecoration(labelText: 'Primary Fitness Goal'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _saveProfile,
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: _logout,
                  child: Text('Logout'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
