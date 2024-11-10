import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  final List<String> songs = [
    'Closer',
    'Baby',
    'Espresso',
    'Desi Kalakar',
    'Zara Sa',
    'Hale Dil',
    'Attention',
    'We Don\'t Talk Anymore',
    'Harleys in Hawaii',
    'Fuck Up the Friendship',
    'Señorita'
  ];

  final List<String> songImageUrls = [
    'https://i.ytimg.com/vi/u-YGV5xt-jk/maxresdefault.jpg',
    'https://i.ytimg.com/vi/GqWYJT-iMTw/maxresdefault.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMdyjgChErneVGIChzmLVWwXF8TUofMuI3Aw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHvxarvqom9RYlQX-9Q2z68_TPGYyTYKrLiQ&s',
    'https://c.saavncdn.com/801/Jannat-Hindi-2008-20190629135803-500x500.jpg',
    'https://i.ytimg.com/vi/BAp87r3dWUE/maxresdefault.jpg',
    'https://i.scdn.co/image/ab67616d0000b273897f73256b9128a9d70eaf66',
    'https://m.media-amazon.com/images/M/MV5BNmFlOWJkOTUtMzk5Ni00YjcxLTkyZTAtZjg5NmIzMTRkNjZkXkEyXkFqcGc@._V1_.jpg',
    'https://m.media-amazon.com/images/M/MV5BNjkyMzU1MzYtODQ0OS00NDg3LWEyN2MtMzk0MmFmODUwOGY5XkEyXkFqcGc@._V1_.jpg',
    'https://i.scdn.co/image/ab67616d00001e022f35152ea0744bab4fafac46',
    'https://i.ytimg.com/vi/Pkh8UtuejGw/maxresdefault.jpg'
  ];

  final List<String> albums = ['Album 1', 'Album 2', 'Album 3', 'Album 4'];
  final List<String> artists = ['Artist 1', 'Artist 2', 'Artist 3', 'Artist 4'];
  final List<String> playlists = ['Liked Songs', 'Rock Classic', 'HeartStrings'];

  final List<String> playlistImageUrls = [
    'https://img.freepik.com/premium-photo/green-heart-with-green-heart-that-says-heart_1172671-17420.jpg',
    'https://mrwallpaper.com/images/hd/avengers-iphone-with-supernatural-portal-p2oz8f87rfsczkgo.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyRZrrvULpQkaNDDb2pF-SrdjJkIZodzEyNw&s',
  ];

  final List<String> placeholderImageUrls = [
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.account_circle, color: Colors.white, size: 35),
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
        title: Text(
          "Your Library",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white, size: 30),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              indicatorColor: Colors.greenAccent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  child: Text(
                    'Songs',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Tab(
                  child: Text(
                    'Albums',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Tab(
                  child: Text(
                    'Artists',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Tab(
                  child: Text(
                    'Playlists',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildLibrarySectionWithImages(songs, "No songs added yet.", songImageUrls),
                  _buildLibrarySectionWithImages(albums, "No albums found.", placeholderImageUrls),
                  _buildLibrarySectionWithImages(artists, "No artists available.", placeholderImageUrls),
                  _buildLibrarySectionWithImages(playlists, "No playlists created.", playlistImageUrls),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
      ),
    );
  }

  Widget _buildLibrarySectionWithImages(List<String> items, String placeholder, List<String> imageUrls) {
    return items.isNotEmpty
        ? ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // Use the provided image URL or fallback to placeholder if out of range
        String imageUrl = index < imageUrls.length ? imageUrls[index] : placeholderImageUrls[index % placeholderImageUrls.length];
        return Card(
          color: Colors.grey[800],
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
              ),
            ),
            title: Text(
              items[index],
              style: TextStyle(color: Colors.white, fontSize: 22),
              textAlign: TextAlign.center,
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
