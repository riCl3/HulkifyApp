import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _recentSearches = []; // Holds the recent searches
  List<String> _searchResults = []; // Holds the current search results

  // Function to handle search
  void _handleSearch(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _searchResults = List.generate(5, (index) => '$query Result #${index + 1}');
        if (!_recentSearches.contains(query)) {
          _recentSearches.insert(0, query); // Add to recent searches
        }
      });
    }
  }

  // Function to handle tapping on a recent search
  void _handleRecentSearch(String query) {
    setState(() {
      _searchController.text = query;
      _searchResults = List.generate(5, (index) => '$query Result #${index + 1}');
    });
  }

  // Function to clear recent searches
  void _clearRecentSearches() {
    setState(() {
      _recentSearches.clear();
    });
  }

  // Handle navigation when an item in the bottom navigation bar is tapped
  void _onBottomNavTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/search');
        break;
      case 2:
        Navigator.pushNamed(context, '/library');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Increase AppBar height
        child: Stack(
          children: [
            AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
            ),
            Positioned(
              left: 10, // Move the content left further
              top: 30,  // Move it further down from the top
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
                    "Search",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'sans-serif',
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search songs, artists...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                ),
                onChanged: (query) {
                  if (query.isEmpty) {
                    setState(() {
                      _searchResults.clear();
                    });
                  } else {
                    _handleSearch(query);
                  }
                },
              ),
            ),

            // Recent Searches Section
            _recentSearches.isNotEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Searches",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 10),
                Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _recentSearches.length,
                    itemBuilder: (context, index) {
                      String recentSearch = _recentSearches[index];
                      return GestureDetector(
                        onTap: () => _handleRecentSearch(recentSearch),
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              recentSearch,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
                : SizedBox.shrink(),

            SizedBox(height: 20),

            // Search Results Section
            _searchResults.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _searchResults[index],
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Handle what happens when a search result is tapped (e.g., play the song, show details)
                    },
                  );
                },
              ),
            )
                : Center(
              child: Text(
                "No results found",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set to 1 to indicate the current Search screen
        onTap: _onBottomNavTapped,
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
}
