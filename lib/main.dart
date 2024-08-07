// lib/main.dart

import 'package:flutter/material.dart';
import 'package:news_app/news_detail.dart';
import 'news_api.dart'; // Import the news_api.dart file

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 16),
        ),
      ),
      home: NewsListView(),
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
        title: Text('News App'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: news,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news available'));
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
