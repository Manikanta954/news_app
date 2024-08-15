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
    // Fetch news only once during the initialization of the widget
    news = fetchNews();
  }

  // Method to refresh the news list
  Future<void> _refreshNews() async {
    setState(() {
      news = fetchNews(); // Refetch news when pulled down
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pigi',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: RefreshIndicator(
          onRefresh: _refreshNews, // Pull-to-refresh callback
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
