import 'package:flutter/material.dart';
import 'package:hulkify/screens/song_player_screen.dart';
import '../models/mood_category.dart'; // Import the MoodCategory model

class CategorySongsScreen extends StatelessWidget {
  final MoodCategory category;

  CategorySongsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          category.title,
          style: TextStyle(color: Colors.greenAccent, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: category.songs.length,
        itemBuilder: (context, index) {
          final song = category.songs[index];
          return ListTile(
            title: Text(
              song['title']!,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            subtitle: Text(
              song['artist']!,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            onTap: () {
              // Navigate to the SongPlayerScreen for the selected song
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongPlayerScreen(
                    title: song['title']!,
                    artist: song['artist']!,
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
