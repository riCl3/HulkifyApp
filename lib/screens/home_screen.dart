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
  String? _minimizedSongTitle;
  String? _minimizedArtistName;

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

  final List<String> defaultCategories = [
    'Top Songs',
    'Favorite Songs',
    'Release Radar',
    'Avenge Now!',
  ];

  final List<List<Color>> gradients = [
    [Colors.purple, Colors.pinkAccent],
    [Colors.blue, Colors.lightBlueAccent],
    [Colors.green, Colors.lightGreenAccent],
    [Colors.orange, Colors.deepOrangeAccent],
  ];

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

  List<dynamic> _getRandomizedCategories() {
    List<dynamic> categories = [
      ...defaultCategories,
      ...moodCategories,
    ];
    categories.shuffle();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Text(
              "Recommended Songs",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Flexible(
              flex: 3,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, rowIndex) {
                  return SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _openSongPlayer('Song ${index + 1}', 'Artist ${index + 1}'),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SongCard(
                              title: 'Song ${index + 1}',
                              artist: 'Artist ${index + 1}',
                              gradientColors: gradients[index % gradients.length],
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
      onTap: () {},
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
    Map<String, List<Color>> moodColors = {
      'Romantic': [Colors.pink.shade700, Colors.pink.shade400],
      'Workout': [Colors.orange.shade700, Colors.orange.shade400],
    };

    return GestureDetector(
      onTap: () {
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
}


//Proper Code