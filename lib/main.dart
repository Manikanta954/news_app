import 'package:flutter/material.dart';
import 'package:news_app/news_detail.dart';
import 'news_api.dart'; // Import the news_api.dart file
import 'search_page.dart'; // Import the search_page.dart
import 'saved_news_page.dart'; // Import the saved_news_page.dart
import 'add_news_page.dart'; // Import the add_news_page.dart
import 'my_account_page.dart'; // Import the my_account_page.dart

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quick News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 16),
        ),
      ),
      home: BottomNavBar(), // Set the home to the BottomNavBar widget
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    NewsListView(), // Home Page with news
    SearchPage(), // Search Page
    SavedNewsPage(), // Saved News Page
    AddNewsPage(), // Add News Page
    MyAccountPage(), // My Account Page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 40,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,color: Colors.black,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_rounded,color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline,color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined,color: Colors.black),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class NewsListView extends StatefulWidget {
  @override
  _NewsListViewState createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  late Future<List<dynamic>> news;

  @override
  void initState() {
    super.initState();
    news = fetchNews(); // Fetch news on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick News'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: news,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available'));
          } else {
            return PageView.builder(
              scrollDirection: Axis.vertical, // Vertical scrolling
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return NewsDetail(article: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
