import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // For Firebase Authentication
import 'package:firebase_core/firebase_core.dart'; // For Firebase initialization
import '../services/auth_service.dart'; // Custom AuthService for sign-out

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  final AuthService _authService = AuthService();
  bool _isExpanded = false;

  final String userEmail = 'user@example.com';
  final String userBio = 'Loves coding, music, and exploring new tech trends.';

  // Step 1: Define a state variable for the selected avatar
  String _selectedAvatarPath = 'assets/hulk.png'; // Default avatar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Hulk-inspired textured background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade900, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Step 4: Add GestureDetector to open avatar selection on tap
                GestureDetector(
                  onTap: () => _selectAvatar(context), // Open avatar selection
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(_selectedAvatarPath),
                    onBackgroundImageError: (_, __) => setState(() {}),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  userEmail,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16),

                // Expanding Card for User Stats
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: _isExpanded ? 180 : 80,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedCrossFade(
                          firstChild: Text(
                            'Tap to view stats',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          secondChild: Column(
                            children: [
                              SizedBox(height: 8),
                              Text(
                                'Playlists: 12',
                                style: TextStyle(color: Colors.greenAccent, fontSize: 18),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Followers: 305',
                                style: TextStyle(color: Colors.greenAccent, fontSize: 18),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Following: 180',
                                style: TextStyle(color: Colors.greenAccent, fontSize: 18),
                              ),
                            ],
                          ),
                          crossFadeState: _isExpanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: Duration(milliseconds: 300),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Updated ElevatedButton Style
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadowColor: Colors.greenAccent.withOpacity(0.4),
                    elevation: 6,
                  ),
                  onPressed: () async {
                    await _authService.signOut();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.logout, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),

                Divider(
                  color: Colors.grey.shade700,
                  thickness: 0.5,
                  indent: 50,
                  endIndent: 50,
                ),
                SizedBox(height: 20),
                Text(
                  'Powered by Your App',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showResetDialog(context), // Show reset confirmation dialog
        backgroundColor: Colors.greenAccent,
        child: Icon(Icons.settings, color: Colors.black),
      ),
    );
  }

  // Step 5: Define the avatar selection method
  void _selectAvatar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final List<Map<String, String>> avatars = [
          {'name': 'Hulk', 'path': 'assets/hulk.png'},
          {'name': 'Iron Man', 'path': 'assets/ironman.png'},
          {'name': 'Captain America', 'path': 'assets/captain_america.png'},
          {'name': 'Thor', 'path': 'assets/thor.png'},
          {'name': 'Scarlet Witch', 'path': 'assets/scarlet_witch.png'},
        ];

        return GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: avatars.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedAvatarPath = avatars[index]['path']!;
                });
                Navigator.pop(context);
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(avatars[index]['path']!),
                  ),
                  SizedBox(height: 6),
                  Text(
                    avatars[index]['name']!,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Method to reset all settings to default
  void _resetSettings() {
    setState(() {
      _selectedAvatarPath = 'assets/hulk.png'; // Reset to default avatar
      _isExpanded = false; // Reset other settings as needed
    });
  }

  // Show a confirmation dialog for reset
  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Reset Settings',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Are you sure you want to reset all settings to default?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.greenAccent)),
            ),
            TextButton(
              onPressed: () {
                _resetSettings();
                Navigator.of(context).pop();
              },
              child: Text('Reset', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }
}
