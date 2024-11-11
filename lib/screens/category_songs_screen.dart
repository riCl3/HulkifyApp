import 'package:flutter/material.dart';
import 'package:hulkify/screens/song_player_screen.dart';
import '../models/mood_category.dart'; // Import the MoodCategory model

// This screen displays songs based on a specific mood category selected by the user.
class CategorySongsScreen extends StatelessWidget {
  // The MoodCategory object passed into this screen contains details about the selected category, including the list of songs.
  final MoodCategory category;

  // Constructor to accept and initialize the mood category for this screen.
  CategorySongsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color of the entire screen to black for a sleek, music-player look.
      backgroundColor: Colors.black,
      
      // App bar with the category title displayed in the center.
      appBar: AppBar(
        backgroundColor: Colors.black, // Match the background color of the app bar with the screen.
        title: Text(
          category.title, // Display the title of the selected mood category.
          style: TextStyle(
            color: Colors.greenAccent, // Use a vibrant green color for text to match the Hulk theme.
            fontSize: 24,
            fontWeight: FontWeight.bold, // Make the title bold to stand out.
          ),
        ),
        centerTitle: true, // Center-align the title on the app bar.
      ),
      
      // Main content area - a scrollable list of songs within the selected category.
      body: ListView.builder(
        itemCount: category.songs.length, // Set the item count to the number of songs in the category.
        
        // Define how each song in the list should appear on the screen.
        itemBuilder: (context, index) {
          final song = category.songs[index]; // Get the song at the current index.
          
          return ListTile(
            title: Text(
              song['title']!, // Display the song title.
              style: TextStyle(color: Colors.white, fontSize: 18), // Style the title with a white color for visibility.
            ),
            subtitle: Text(
              song['artist']!, // Display the artist's name as the subtitle.
              style: TextStyle(color: Colors.white70, fontSize: 14), // Use a lighter color to distinguish it from the title.
            ),
            
            // When a song is tapped, navigate to the SongPlayerScreen for that specific song.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongPlayerScreen(
                    title: song['title']!, // Pass the song title to the player screen.
                    artist: song['artist']!, // Pass the artist name to the player screen.
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
