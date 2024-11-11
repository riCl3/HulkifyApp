import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'models/mood_category.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/library_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/song_player_screen.dart'; // Import for song player screen
import 'screens/category_songs_screen.dart'; // Import for category songs screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(HulkifyApp());
}

class HulkifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hulkify',
      theme: ThemeData(
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.black,
          secondary: Colors.greenAccent,
          brightness: Brightness.dark,
        ),
      ),
      // Change initialRoute to '/' to load the SplashScreen first
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        '/library': (context) => LibraryScreen(),
        '/settings': (context) => SettingsScreen(),
        '/profile': (context) => ProfileScreen(),
        '/songPlayer': (context) => SongPlayerScreen(title: '', artist: ''),
        '/categorySongs': (context) => CategorySongsScreen(category: MoodCategory(title: '', songs: [])),
      },
    );
  }
}


//Proper Code