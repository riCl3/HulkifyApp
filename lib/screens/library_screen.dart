import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final List<String> songs = [
    'Closer', 'Baby', 'Espresso', 'Desi Kalakar', 'Zara Sa',
    'Hale Dil', 'Attention', 'We Don\'t Talk Anymore', 'Harleys in Hawaii',
    'Fuck Up the Friendship', 'Señorita'
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

  final List<String> albums = [
    'Aashique 2', 'Jab We Met', 'Ajab Prem Ki Ghazab Kahani', 'Jannat 2', 'Genius', 'Chhichhore'
  ];

  final List<String> albumImageUrls = [
    'https://assets-in.bmscdn.com/discovery-catalog/events/et00013287-vnqbwzksbl-landscape.jpg',
    'https://m.media-amazon.com/images/M/MV5BOTk0NDU0OGEtZTRlMy00ZTZkLWJiYmEtN2QwMzBhNTg2N2I0XkEyXkFqcGc@._V1_.jpg',
    'https://img.mensxp.com/media/content/2021/Dec/What-Ajab-Prem-Ki-Ghazab-Kahani-Is-Really-About1200_61b205b9c6e8f.jpeg',
    'https://i.scdn.co/image/ab67616d0000b27371da5e89467bd75d2ed9f1fa',
    'https://m.media-amazon.com/images/M/MV5BOTM3NzVkZDQtMjgzMC00OTcxLWE1YTEtNjhlNDYyNjg3MGYxXkEyXkFqcGc@._V1_.jpg',
    'https://images.indianexpress.com/2019/09/chhichhore-movie-review-759.jpg',
  ];

  final List<String> artists = [
    'Arijit Singh', 'Honey Singh', 'Krishnakumar Kunnath (KK)', 'Sonu Nigam', 'Sunidhi Chauhan',
    'Justin Bieber', 'Charlie Puth', 'Shreya Ghoshal'
  ];

  final List<String> artistImageUrls = [
    'https://static.toiimg.com/thumb/imgsize-23456,msid-92037952,width-600,resizemode-4/92037952.jpg',
    'https://i.pinimg.com/550x/55/1a/7a/551a7a8bea201bb7d2ba8adc1302760f.jpg',
    'https://www.navhindtimes.in/wp-content/uploads/2022/06/1606731360_KK_1.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtXCqErXOOufvU65CDKzSQL9_gTflk1tYZZQ&s',
    'https://pbs.twimg.com/media/GZXKQU6WgAAgDnd?format=jpg&name=large',
    'https://i.pinimg.com/550x/9e/4d/9a/9e4d9a80ed803c7351cdcf73cb977048.jpg',
    'https://static01.nyt.com/images/2018/05/27/arts/27PUTH1/27PUTH1-videoSixteenByNineJumbo1600.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEK-8Ptx5VUBkTVHFGo5aS8IJobj9FvwJnJw&s',
  ];

  final List<String> playlists = ['Liked Songs', 'Rock Classic', 'HeartStrings'];

  final List<String> playlistImageUrls = [
    'https://img.freepik.com/premium-photo/green-heart-with-green-heart-that-says-heart_1172671-17420.jpg',
    'https://mrwallpaper.com/images/hd/avengers-iphone-with-supernatural-portal-p2oz8f87rfsczkgo.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyRZrrvULpQkaNDDb2pF-SrdjJkIZodzEyNw&s',
  ];

  final Set<String> likedSongs = {}; // Track liked songs only

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
                Tab(child: Text('Songs', style: TextStyle(fontSize: 16))),
                Tab(child: Text('Albums', style: TextStyle(fontSize: 16))),
                Tab(child: Text('Artists', style: TextStyle(fontSize: 16))),
                Tab(child: Text('Playlists', style: TextStyle(fontSize: 16))),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildLibrarySectionWithImages(songs, "No songs added yet.", songImageUrls, true),
                  _buildLibrarySectionWithImages(albums, "No albums found.", albumImageUrls, false),
                  _buildLibrarySectionWithImages(artists, "No artists available.", artistImageUrls, false),
                  _buildLibrarySectionWithImages(playlists, "No playlists created.", playlistImageUrls, false),
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

  Widget _buildLibrarySectionWithImages(
      List<String> items, String placeholder, List<String> imageUrls, bool isSongSection) {
    return items.isNotEmpty
        ? ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrls[index],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            items[index],
            style: TextStyle(color: Colors.white),
          ),
          trailing: isSongSection
              ? IconButton(
            icon: Icon(
              likedSongs.contains(items[index])
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                if (likedSongs.contains(items[index])) {
                  likedSongs.remove(items[index]);
                } else {
                  likedSongs.add(items[index]);
                }
              });
            },
          )
              : null,
        );
      },
    )
        : Center(
      child: Text(
        placeholder,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

