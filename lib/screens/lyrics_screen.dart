import 'package:flutter/material.dart';

class SongPlayerScreen extends StatefulWidget {
  final String title;
  final String artist;

  const SongPlayerScreen({required this.title, required this.artist});

  @override
  _SongPlayerScreenState createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  bool _isPlaying = false;
  bool _isRepeating = false;
  bool _isShuffling = false;
  double _sliderValue = 0.0; // Track song progress
  double _songLength = 180.0; // Total song length in seconds (example 3 minutes)
  String _currentTime = "0:00"; // Current time on the slider
  int _currentSongIndex = 0; // To track current song in the playlist

  // List of song titles (you can replace it with actual song data later)
  List<Map<String, String>> songList = [
    {"title": "Song 1", "artist": "Artist 1"},
    {"title": "Song 2", "artist": "Artist 2"},
    {"title": "Song 3", "artist": "Artist 3"},
  ];

  // Update current time based on slider value
  void _updateCurrentTime() {
    int minutes = (_sliderValue ~/ 60).toInt();
    int seconds = (_sliderValue % 60).toInt();
    setState(() {
      _currentTime = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    });
  }

  // Play/Pause toggle method
  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  // Toggle Repeat button
  void _toggleRepeat() {
    setState(() {
      _isRepeating = !_isRepeating;
    });
  }

  // Toggle Shuffle button
  void _toggleShuffle() {
    setState(() {
      _isShuffling = !_isShuffling;
    });
  }

  // Play the previous song
  void _previousSong() {
    setState(() {
      _currentSongIndex = (_currentSongIndex - 1) % songList.length;
      _sliderValue = 0.0; // Reset slider when song changes
    });
  }

  // Play the next song
  void _nextSong() {
    setState(() {
      _currentSongIndex = (_currentSongIndex + 1) % songList.length;
      _sliderValue = 0.0; // Reset slider when song changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Now Playing', style: TextStyle(color: Colors.greenAccent)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Song Title and Artist
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                songList[_currentSongIndex]["title"]!,
                style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Text(
                songList[_currentSongIndex]["artist"]!,
                style: TextStyle(color: Colors.white70, fontSize: 20),
              ),
            ),
            // Slider for song progress
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_currentTime, style: TextStyle(color: Colors.white)),
                      Text(
                        "${(_songLength ~/ 60).toInt().toString().padLeft(2, '0')}:${(_songLength % 60).toInt().toString().padLeft(2, '0')}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Slider(
                    value: _sliderValue,
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                        _updateCurrentTime();
                      });
                    },
                    min: 0,
                    max: _songLength,
                    activeColor: Colors.greenAccent,
                    inactiveColor: Colors.white30,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Song Artwork (Placeholder)
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(Icons.music_note, color: Colors.white, size: 100),
              ),
            ),
            SizedBox(height: 40),
            // Play/Pause Button
            IconButton(
              onPressed: _togglePlayPause,
              icon: Icon(
                _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                size: 70,
                color: Colors.greenAccent,
              ),
            ),
            SizedBox(height: 30),
            // Controls: Previous, Play/Pause, Next, Repeat, Shuffle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Previous button
                IconButton(
                  onPressed: _previousSong,
                  icon: Icon(
                    Icons.skip_previous,
                    size: 40,
                    color: Colors.greenAccent,
                  ),
                ),
                SizedBox(width: 30),
                // Repeat button
                IconButton(
                  onPressed: _toggleRepeat,
                  icon: Icon(
                    _isRepeating ? Icons.repeat_one : Icons.repeat,
                    size: 40,
                    color: Colors.greenAccent,
                  ),
                ),
                SizedBox(width: 30),
                // Next button
                IconButton(
                  onPressed: _nextSong,
                  icon: Icon(
                    Icons.skip_next,
                    size: 40,
                    color: Colors.greenAccent,
                  ),
                ),
                SizedBox(width: 30),
                // Shuffle button
                IconButton(
                  onPressed: _toggleShuffle,
                  icon: Icon(
                    _isShuffling ? Icons.shuffle : Icons.shuffle_rounded,
                    size: 40,
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
