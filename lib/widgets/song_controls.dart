import 'package:flutter/material.dart';
import 'package:hulkify/services/music_service.dart';

class SongControls extends StatelessWidget {
  final MusicService musicService;

  SongControls({required this.musicService});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () {
              // Shuffle functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: () {
              musicService.previousTrack();
            },
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              musicService.playPause();
            },
          ),
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: () {
              musicService.nextTrack();
            },
          ),
          IconButton(
            icon: Icon(Icons.repeat),
            onPressed: () {
              // Repeat functionality
            },
          ),
        ],
      ),
    );
  }
}
