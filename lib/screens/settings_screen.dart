import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Ensure Firebase is initialized
import '../widgets/custom_button.dart'; // Custom button widget

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _bassValue = 50.0;
  double _midValue = 50.0;
  double _trebleValue = 50.0;
  double _highValue = 50.0;

  // Sign-out functionality
  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase
      Navigator.pushReplacementNamed(context, '/login'); // Navigate to login screen
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  // Reset Equalizer Settings
  void _resetEqualizer() {
    setState(() {
      _bassValue = 50.0;
      _midValue = 50.0;
      _trebleValue = 50.0;
      _highValue = 50.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.greenAccent, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Equalizer Section
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Equalizer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSlider("Bass", _bassValue, (newValue) {
                        setState(() {
                          _bassValue = newValue;
                        });
                      }),
                      _buildSlider("Mid", _midValue, (newValue) {
                        setState(() {
                          _midValue = newValue;
                        });
                      }),
                      _buildSlider("Treble", _trebleValue, (newValue) {
                        setState(() {
                          _trebleValue = newValue;
                        });
                      }),
                      _buildSlider("High", _highValue, (newValue) {
                        setState(() {
                          _highValue = newValue;
                        });
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Reset Equalizer Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: "Reset Equalizer",
              onPressed: _resetEqualizer,
            ),
          ),
          // Sign Out Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: "Sign Out",
              onPressed: _signOut,
            ),
          ),
          // App Version Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "App Version: 1.0.0",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          // About Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "About the App\nA music streaming app for Avengers made by The Hard Coders with love!",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function for equalizer sliders
  Widget _buildSlider(String label, double value, Function(double) onChanged) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 160,
          child: RotatedBox(
            quarterTurns: 3,
            child: Slider(
              value: value,
              min: 0,
              max: 100,
              onChanged: onChanged,
              activeColor: Colors.greenAccent,
              inactiveColor: Colors.white38,
            ),
          ),
        ),
      ],
    );
  }
}
