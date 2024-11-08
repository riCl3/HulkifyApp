import 'package:flutter/material.dart';

class SongPlayerScreen extends StatefulWidget {
  final String title;
  final String artist;

  SongPlayerScreen({required this.title, required this.artist});

  @override
  _SongPlayerScreenState createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  bool isRepeatOn = false;
  bool isShuffleOn = false;
  double currentSliderValue = 0.0;
  double songDuration = 180.0; // assuming song duration of 3 minutes (180 seconds)

  List<String> songQueue = ["Song 1", "Song 2", "Song 3", "Song 4"];

  // Function to show the queue
  void _showQueue() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Colors.black,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              "Queue",
              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.grey),
            for (var song in songQueue)
              ListTile(
                title: Text(song, style: TextStyle(color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.queue_music, color: Colors.white),
            onPressed: _showQueue,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Song Image
          Container(
            width: 200,
            height: 200,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.music_note, size: 100, color: Colors.white),
          ),
          Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 24)),
          Text(widget.artist, style: TextStyle(color: Colors.grey, fontSize: 16)),

          // Slider for song progress
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Slider(
                  value: currentSliderValue,
                  min: 0.0,
                  max: songDuration,
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      currentSliderValue = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(currentSliderValue),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      _formatDuration(songDuration),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Playback Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    isShuffleOn ? Icons.shuffle : Icons.shuffle_outlined,
                    color: isShuffleOn ? Colors.green : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isShuffleOn = !isShuffleOn;
                    });
                  },
                ),
                Icon(Icons.skip_previous, color: Colors.white, size: 36),
                Icon(Icons.play_arrow, color: Colors.green, size: 48),
                Icon(Icons.skip_next, color: Colors.white, size: 36),
                IconButton(
                  icon: Icon(
                    isRepeatOn ? Icons.repeat : Icons.repeat_one_outlined,
                    color: isRepeatOn ? Colors.green : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isRepeatOn = !isRepeatOn;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to format duration from seconds to mm:ss
  String _formatDuration(double seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = (seconds % 60).toInt();
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
