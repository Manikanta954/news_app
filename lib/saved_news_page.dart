import 'package:flutter/material.dart';
import 'news_card.dart';

List<dynamic> savedNews = [];

void addToSavedNews(dynamic article) {
  savedNews.add(article);
}

void removeFromSavedNews(dynamic article) {
  savedNews.remove(article);
}

class SavedNewsPage extends StatefulWidget {
  @override
  _SavedNewsPageState createState() => _SavedNewsPageState();
}

class _SavedNewsPageState extends State<SavedNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved News'),
      ),
      body: ListView.builder(
        itemCount: savedNews.length,
        itemBuilder: (context, index) {
          return NewsCard(article: savedNews[index]);
        },
      ),
    );
  }
}
