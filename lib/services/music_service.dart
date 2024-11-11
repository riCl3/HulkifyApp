import 'package:flutter/material.dart';

class MusicService extends ChangeNotifier {
  bool isPlaying = false;
  int currentTrack = 0;
  List<String> queue = ['Song 1', 'Song 2', 'Song 3']; // Sample song titles for queue

  void playPause() {
    isPlaying = !isPlaying;
    notifyListeners();
  }

  void nextTrack() {
    if (currentTrack < queue.length - 1) {
      currentTrack++;
    } else {
      currentTrack = 0; // Loop back to the start of the queue
    }
    notifyListeners();
  }

  void previousTrack() {
    if (currentTrack > 0) {
      currentTrack--;
    } else {
      currentTrack = queue.length - 1; // Loop back to the end of the queue
    }
    notifyListeners();
  }

  void addToQueue(String song) {
    queue.add(song);
    notifyListeners();
  }
}


//Proper Code