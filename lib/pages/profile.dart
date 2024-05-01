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
        if (_nameController.text.isEmpty ||
            _ageController.text.isEmpty ||
            _weightController.text.isEmpty ||
            _heightController.text.isEmpty ||
            _dietController.text.isEmpty ||
            _goalController.text.isEmpty ||
            _selectedGender == null ||
            _selectedGender?.isEmpty == true) {
          // Handle empty fields
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Error'),
              content: Text('Please fill in all the fields'),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          );
          return;
        }
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
      backgroundColor: Color.fromARGB(255, 215, 217, 218),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 12.0),
        // ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Color.fromARGB(255, 231, 97, 64)),
        ),
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
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  value: _selectedGender,
                  items: <String>['Male', 'Female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    _selectedGender = newValue;
                  },
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _heightController,
                  decoration: InputDecoration(
                    labelText: 'Height',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _weightController,
                  decoration: InputDecoration(
                    labelText: 'Weight',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _goalController,
                  decoration: InputDecoration(
                    labelText: 'Primary Fitness Goal',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _dietController,
                  decoration: InputDecoration(
                    labelText: 'Dietary Restrictions',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Adjust the spacing as needed
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: _saveProfile,
                            child: Text('Save'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Color.fromARGB(255, 143, 148, 152),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: _logout,
                            child: Text('Logout'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Color.fromARGB(255, 143, 148, 152),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
