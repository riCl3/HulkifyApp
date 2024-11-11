import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart'; // For Clipboard functionality

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
  double _sliderValue = 0.0;
  double _songLength = 180.0; // Total song length in seconds (example 3 minutes)
  String _currentTime = "0:00";
  int _currentSongIndex = 0;

  // List of song titles for example (You can replace it with actual song data later)
  List<Map<String, String>> songList = [
    {"title": "Song 1", "artist": "Artist 1"},
    {"title": "Song 2", "artist": "Artist 2"},
    {"title": "Song 3", "artist": "Artist 3"},
  ];

  // Timer to update slider as the song plays
  Timer? _timer;

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
    if (_isPlaying) {
      _timer?.cancel(); // Stop the timer when paused
    } else {
      _startTimer(); // Start the timer when playing
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  // Start a timer to simulate song playing
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_sliderValue < _songLength) {
        setState(() {
          _sliderValue += 1;
          _updateCurrentTime();
        });
      } else {
        _timer?.cancel();
      }
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
      _updateCurrentTime();
    });
  }

  // Play the next song
  void _nextSong() {
    setState(() {
      _currentSongIndex = (_currentSongIndex + 1) % songList.length;
      _sliderValue = 0.0; // Reset slider when song changes
      _updateCurrentTime();
    });
  }

  // Open lyrics modal
  void _showLyrics() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Lyrics for ${songList[_currentSongIndex]['title']}",
                  style: TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "Here are the lyrics for the song...",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close', style: TextStyle(color: Colors.greenAccent)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Open queue modal
  void _showQueue() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Queue",
                  style: TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  itemCount: songList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        songList[index]["title"]!,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        songList[index]["artist"]!,
                        style: TextStyle(color: Colors.white70),
                      ),
                      onTap: () {
                        // Update the current song when a song is selected from the queue
                        setState(() {
                          _currentSongIndex = index;
                          _sliderValue = 0.0; // Reset slider when song changes
                          Navigator.pop(context); // Close queue dialog
                        });
                      },
                    );
                  },
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close', style: TextStyle(color: Colors.greenAccent)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Share song ID functionality
  void _shareSong() {
    final songId = "Song ID: ${songList[_currentSongIndex]['title']}";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.8),
          title: Text("Share Song", style: TextStyle(color: Colors.greenAccent)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                songId,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: songId));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Song ID copied to clipboard!", style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.greenAccent,
                  ));
                },
                child: Text("Copy ID", style: TextStyle(color: Colors.greenAccent)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Stop the timer when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for the entire screen
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Now Playing', style: TextStyle(color: Colors.greenAccent)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.queue_music, color: Colors.greenAccent),
            onPressed: _showQueue, // Show queue on press
          ),
          IconButton(
            icon: Icon(Icons.closed_caption, color: Colors.greenAccent),
            onPressed: _showLyrics, // Show lyrics on press
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.greenAccent),
            onPressed: _shareSong, // Show share dialog on press
          ),
        ],
      ),
      body: SingleChildScrollView( // Added to prevent overflow
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              // Song Artwork (Placeholder)
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(Icons.music_note, color: Colors.white, size: 100),
                ),
              ),
              SizedBox(height: 40),
              // Slider and Time Controls
              Slider(
                value: _sliderValue,
                onChanged: (newValue) {
                  setState(() {
                    _sliderValue = newValue;
                    _updateCurrentTime();
                  });
                },
                max: _songLength,
                activeColor: Colors.greenAccent,
                inactiveColor: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _currentTime,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    "${(_songLength / 60).toStringAsFixed(0)}:00",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Control Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous, color: Colors.greenAccent),
                    onPressed: _previousSong, // Previous song
                  ),
                  IconButton(
                    icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.greenAccent),
                    onPressed: _togglePlayPause, // Play/Pause
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next, color: Colors.greenAccent),
                    onPressed: _nextSong, // Next song
                  ),
                ],
              ),
              // Repeat and Shuffle buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                        _isRepeating ? Icons.repeat : Icons.repeat_one,
                        color: Colors.greenAccent),
                    onPressed: _toggleRepeat, // Toggle repeat
                  ),
                  IconButton(
                    icon: Icon(
                        _isShuffling ? Icons.shuffle : Icons.shuffle_on,
                        color: Colors.greenAccent),
                    onPressed: _toggleShuffle, // Toggle shuffle
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Proper Code