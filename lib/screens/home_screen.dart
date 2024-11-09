import 'dart:math'; // For random order
import 'package:flutter/material.dart';
import '../widgets/song_card.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/minimized_player.dart';
import 'song_player_screen.dart';
import '../models/mood_category.dart'; // Import MoodCategory model

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _minimizedSongTitle;
  String? _minimizedArtistName;

  final List<MoodCategory> moodCategories = [
    MoodCategory(
      title: 'Romantic',
      songs: [
        {'title': 'Love Story', 'artist': 'Taylor Swift'},
        {'title': 'Perfect', 'artist': 'Ed Sheeran'},
        {'title': 'All of Me', 'artist': 'John Legend'},
        {'title': 'I Will Always Love You', 'artist': 'Whitney Houston'},
        {'title': 'Just the Way You Are', 'artist': 'Bruno Mars'},
      ],
    ),
    MoodCategory(
      title: 'Workout',
      songs: [
        {'title': 'Eye of the Tiger', 'artist': 'Survivor'},
        {'title': 'Stronger', 'artist': 'Kanye West'},
        {'title': 'Lose Yourself', 'artist': 'Eminem'},
        {'title': 'Uptown Funk', 'artist': 'Mark Ronson ft. Bruno Mars'},
        {'title': 'Can’t Hold Us', 'artist': 'Macklemore & Ryan Lewis'},
      ],
    ),
    MoodCategory(
      title: 'Chill',
      songs: [
        {'title': 'Weightless', 'artist': 'Marconi Union'},
        {'title': 'Sunset Lover', 'artist': 'Petit Biscuit'},
        {'title': 'Night Owl', 'artist': 'Galimatias'},
        {'title': 'Cold Little Heart', 'artist': 'Michael Kiwanuka'},
        {'title': 'Lost in Japan', 'artist': 'Shawn Mendes'},
      ],
    ),
    MoodCategory(
      title: 'Sleepy',
      songs: [
        {'title': 'Goodbye Stranger', 'artist': 'Supertramp'},
        {'title': 'Sleepyhead', 'artist': 'Passion Pit'},
        {'title': 'Banana Pancakes', 'artist': 'Jack Johnson'},
        {'title': 'Don’t Dream It’s Over', 'artist': 'Crowded House'},
        {'title': 'Lullaby', 'artist': 'Sia'},
      ],
    ),
    MoodCategory(
      title: 'Breakup',
      songs: [
        {'title': 'Someone Like You', 'artist': 'Adele'},
        {'title': 'Tears Dry On Their Own', 'artist': 'Amy Winehouse'},
        {'title': 'Back to December', 'artist': 'Taylor Swift'},
        {'title': 'We Are Never Ever Getting Back Together', 'artist': 'Taylor Swift'},
        {'title': 'Irreplaceable', 'artist': 'Beyoncé'},
      ],
    ),
  ];

  final List<String> defaultCategories = [
    'Top Songs',
    'Favorite Songs',
    'Release Radar',
    'Avenge Now!',
  ];

  // Function to navigate to the SongPlayerScreen with the title and artist
  void _openSongPlayer(String title, String artist) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongPlayerScreen(title: title, artist: artist),
      ),
    ).then((_) {
      setState(() {
        _minimizedSongTitle = title;
        _minimizedArtistName = artist;
      });
    });
  }

  // Function to randomize the category order
  List<dynamic> _getRandomizedCategories() {
    List<dynamic> categories = [
      ...defaultCategories,
      ...moodCategories,
    ];
    categories.shuffle(); // Shuffle to randomize order
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Hulkify',
          style: TextStyle(color: Colors.greenAccent, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Category grid section
            Flexible(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: _getRandomizedCategories().map((category) {
                  if (category is String) {
                    return _buildCategoryTile(category);
                  } else if (category is MoodCategory) {
                    return _buildMoodCategoryTile(category);
                  }
                  return SizedBox();
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            // Song list section
            Flexible(
              flex: 3,
              child: ListView(
                children: [
                  _buildSongCard('Song 1', 'Artist 1'),
                  _buildSongCard('Song 2', 'Artist 2'),
                  _buildSongCard('Song 3', 'Artist 3'),
                  _buildSongCard('Song 4', 'Artist 4'),
                  _buildSongCard('Song 5', 'Artist 5'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_minimizedSongTitle != null && _minimizedArtistName != null)
            MinimizedPlayer(
              songTitle: _minimizedSongTitle!,
              artistName: _minimizedArtistName!,
              onTap: () {
                _openSongPlayer(_minimizedSongTitle!, _minimizedArtistName!);
              },
            ),
          CustomBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(String title) {
    return GestureDetector(
      onTap: () {}, // Add category functionality here
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodCategoryTile(MoodCategory category) {
    // Define colors for each mood category
    Map<String, List<Color>> moodColors = {
      'Romantic': [Colors.pink.shade700, Colors.pink.shade400],
      'Workout': [Colors.orange.shade700, Colors.orange.shade400],
      'Chill': [Colors.blue.shade700, Colors.blue.shade400],
      'Sleepy': [Colors.purple.shade700, Colors.purple.shade400],
      'Breakup': [Colors.red.shade700, Colors.red.shade400],
    };

    return GestureDetector(
      onTap: () {
        // Handle category tap here
        print(category.title);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: moodColors[category.title] ?? [Colors.grey, Colors.grey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            category.title,
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildSongCard(String title, String artist) {
    return GestureDetector(
      onTap: () => _openSongPlayer(title, artist),
      child: SongCard(
        title: title,
        artist: artist,
      ),
    );
  }
}
