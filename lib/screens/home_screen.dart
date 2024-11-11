import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/song_card.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/minimized_player.dart';
import 'song_player_screen.dart';
import '../models/mood_category.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variables to store the song title and artist name for minimized player display
  String? _minimizedSongTitle;
  String? _minimizedArtistName;

  // Define some mood categories with songs
  final List<MoodCategory> moodCategories = [
    MoodCategory(title: 'Romantic', songs: [
      {'title': 'Love Story', 'artist': 'Taylor Swift'},
      {'title': 'Perfect', 'artist': 'Ed Sheeran'},
    ]),
    MoodCategory(title: 'Workout', songs: [
      {'title': 'Eye of the Tiger', 'artist': 'Survivor'},
      {'title': 'Stronger', 'artist': 'Kanye West'},
    ]),
  ];

  // Some default categories for the grid view
  final List<String> defaultCategories = [
    'Top Songs',
    'Favorite Songs',
    'Release Radar',
    'Avenge Now!',
  ];

  // Define a list of gradient colors for the song cards
  final List<List<Color>> gradients = [
    [Colors.purple, Colors.pinkAccent],
    [Colors.blue, Colors.lightBlueAccent],
    [Colors.green, Colors.lightGreenAccent],
    [Colors.orange, Colors.deepOrangeAccent],
  ];

  // Method to open the song player screen and update the minimized player info
  void _openSongPlayer(String title, String artist) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongPlayerScreen(title: title, artist: artist),
      ),
    ).then((_) {
      // Update minimized player with the selected song after returning
      setState(() {
        _minimizedSongTitle = title;
        _minimizedArtistName = artist;
      });
    });
  }

  // Method to shuffle and get a mix of mood categories and default categories
  List<dynamic> _getRandomizedCategories() {
    List<dynamic> categories = [
      ...defaultCategories,
      ...moodCategories,
    ];
    categories.shuffle(); // Randomize the order
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Hulkify', // App title
          style: TextStyle(color: Colors.greenAccent, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 2, // 2 columns in the grid
                childAspectRatio: 2.5, // Ratio for tile width and height
                mainAxisSpacing: 10, // Vertical space between grid items
                crossAxisSpacing: 10, // Horizontal space between grid items
                children: _getRandomizedCategories().map((category) {
                  // Check type of category to build the right tile
                  if (category is String) {
                    return _buildCategoryTile(category);
                  } else if (category is MoodCategory) {
                    return _buildMoodCategoryTile(category);
                  }
                  return SizedBox(); // Return empty widget for any unexpected type
                }).toList(),
              ),
            ),
            SizedBox(height: 10), // Spacer between the grid and list section
            Text(
              "Recommended Songs", // Title for the recommended songs section
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Flexible(
              flex: 3,
              child: ListView.builder(
                itemCount: 3, // Limit number of rows for recommended songs
                itemBuilder: (context, rowIndex) {
                  return SizedBox(
                    height: 150, // Height of each row
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // Horizontal scrolling for songs
                      itemCount: 8, // Number of songs in each row
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _openSongPlayer('Song ${index + 1}', 'Artist ${index + 1}'),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SongCard(
                              title: 'Song ${index + 1}',
                              artist: 'Artist ${index + 1}',
                              gradientColors: gradients[index % gradients.length], // Cycle through gradients
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Show minimized player if a song is selected
          if (_minimizedSongTitle != null && _minimizedArtistName != null)
            MinimizedPlayer(
              songTitle: _minimizedSongTitle!,
              artistName: _minimizedArtistName!,
              onTap: () {
                // Open full player screen on tapping minimized player
                _openSongPlayer(_minimizedSongTitle!, _minimizedArtistName!);
              },
            ),
          CustomBottomNavigationBar(), // Custom bottom navigation bar
        ],
      ),
    );
  }

  // Builds a tile for default categories in the grid
  Widget _buildCategoryTile(String title) {
    return GestureDetector(
      onTap: () {}, // Add action when tapping category tile if needed
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850], // Tile background color
          borderRadius: BorderRadius.circular(8), // Rounded corners
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

  // Builds a tile for mood categories with gradients
  Widget _buildMoodCategoryTile(MoodCategory category) {
    Map<String, List<Color>> moodColors = {
      'Romantic': [Colors.pink.shade700, Colors.pink.shade400],
      'Workout': [Colors.orange.shade700, Colors.orange.shade400],
    };

    return GestureDetector(
      onTap: () {
        print(category.title); // For debugging, prints the mood category title
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: moodColors[category.title] ?? [Colors.grey, Colors.grey], // Set gradient color based on mood
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
}
