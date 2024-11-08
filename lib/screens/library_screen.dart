import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  final List<String> songs = [
    'Song 1',
    'Song 2',
    'Song 3',
    'Song 4',
    'Song 5',
  ];

  final List<String> albums = [
    'Album 1',
    'Album 2',
    'Album 3',
    'Album 4',
  ];

  final List<String> artists = [
    'Artist 1',
    'Artist 2',
    'Artist 3',
  ];

  final List<String> playlists = [
    'Playlist 1',
    'Playlist 2',
    'Playlist 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Library", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');  // Navigate to settings screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.greenAccent,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Songs'),
                      Tab(text: 'Albums'),
                      Tab(text: 'Artists'),
                      Tab(text: 'Playlists'),
                    ],
                  ),
                  Container(
                    height: 300,
                    child: TabBarView(
                      children: [
                        _buildLibrarySection(songs, "No songs added yet."),
                        _buildLibrarySection(albums, "No albums found."),
                        _buildLibrarySection(artists, "No artists available."),
                        _buildLibrarySection(playlists, "No playlists created."),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/search');
              break;
            case 2:
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Library',
          ),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
      ),
    );
  }

  Widget _buildLibrarySection(List<String> items, String placeholder) {
    return items.isNotEmpty
        ? ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.grey[800],
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              items[index],
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              print("${items[index]} tapped");
            },
          ),
        );
      },
    )
        : Center(
      child: Text(
        placeholder,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
