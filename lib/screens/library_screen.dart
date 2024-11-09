import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  final List<String> songs = [
    'Song 1',
    'Song 2',
    'Song 3',
    'Song 4',
    'Song 5',
    'Song 6',
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
    'Artist 4',
  ];

  final List<String> playlists = [
    'Liked Songs',
    'Rock Classic',
    'HeartStrings',
  ];

  // List of image URLs for Playlists
  final List<String> playlistImageUrls = [
    'https://img.freepik.com/premium-photo/green-heart-with-green-heart-that-says-heart_1172671-17420.jpg',
    'https://mrwallpaper.com/images/thumbnail/avengers-iphone-in-light-blue-backdrop-jnd3hdthfxffb3h7.web',
    'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-560w,f_auto,q_auto:best/streams/2012/July/120703/445726-120703_peter%20parker%20and%20gwen%20stacy.jpg',
  ];

  // Placeholder image URLs for Songs, Albums, and Artists
  final List<String> placeholderImageUrls = [
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Stack(
          children: [
            AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
            ),
            Positioned(
              left: 10,
              top: 30,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.account_circle, color: Colors.white, size: 35),
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Your Library",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'sans-serif',
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: 30,
              child: IconButton(
                icon: Icon(Icons.settings, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.greenAccent,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                        child: Container(
                          width: 80,
                          child: Text(
                            'Songs',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          width: 80,
                          child: Text(
                            'Albums',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          width: 80,
                          child: Text(
                            'Artists',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          width: 90, // Increased width for "Playlists"
                          child: Text(
                            'Playlists',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 300,
                    child: TabBarView(
                      children: [
                        _buildLibrarySectionWithImages(songs, "No songs added yet.", 0),
                        _buildLibrarySectionWithImages(albums, "No albums found.", 1),
                        _buildLibrarySectionWithImages(artists, "No artists available.", 2),
                        _buildLibrarySectionWithImages(playlists, "No playlists created.", 3),
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

  Widget _buildLibrarySectionWithImages(List<String> items, String placeholder, int sectionIndex) {
    return sectionIndex == 3
        ? Column(
      children: [
        Card(
          color: Colors.black,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Icon(Icons.add, color: Colors.white),
            title: Text(
              "Create New Playlist",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onTap: () {
              print("Create New Playlist tapped");
            },
          ),
        ),
        Expanded(
          child: items.isNotEmpty
              ? ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.grey[800],
                margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(playlistImageUrls[index]),
                      ),
                    ),
                  ),
                  title: Center(
                    child: Text(
                      items[index],
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
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
          ),
        ),
      ],
    )
        : items.isNotEmpty
        ? ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.grey[800],
          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(placeholderImageUrls[sectionIndex]),
                ),
              ),
            ),
            title: Center(
              child: Text(
                items[index],
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
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
