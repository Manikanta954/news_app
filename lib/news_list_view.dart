import 'package:flutter/material.dart';
import 'news_card.dart';
import 'news_api.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 0),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pigi',
            style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10),
          child: FutureBuilder<List<dynamic>>(
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
                    return NewsCard(article: snapshot.data![index]);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
