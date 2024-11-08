import 'package:flutter/material.dart';
import '../widgets/song_card.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/minimized_player.dart';
import 'song_player_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _minimizedSongTitle;
  String? _minimizedArtistName;

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
                childAspectRatio: 2.5, // Adjusted to make the items more rectangular
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  _buildCategoryTile('Top Songs'),
                  _buildCategoryTile('Favorite Songs'),
                  _buildCategoryTile('Release Radar'),
                  _buildCategoryTile('Avenge Now!'),
                ],
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
      onTap: () {}, // Add navigation or functionality here
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