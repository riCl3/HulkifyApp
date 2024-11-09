import 'package:flutter/material.dart';

class MinimizedPlayer extends StatelessWidget {
  final String songTitle;
  final String artistName;
  final VoidCallback onTap;

  const MinimizedPlayer({super.key, required this.songTitle, required this.artistName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.grey[850],
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.music_note, color: Colors.greenAccent),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(songTitle, style: TextStyle(color: Colors.white)),
                    Text(artistName, style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
            IconButton(icon: Icon(Icons.play_arrow, color: Colors.white), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
