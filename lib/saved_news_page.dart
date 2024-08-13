import 'package:flutter/material.dart';
import 'news_card.dart';

List<dynamic> savedNews = [];

void addToSavedNews(dynamic article) {
  if (!savedNews.contains(article)) {
    savedNews.add(article);
  }
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
      body: savedNews.isEmpty
          ? Center(
              child: Text('No saved news yet.'),
            )
          : ListView.builder(
              itemCount: savedNews.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    NewsCard(article: savedNews[index]),
                    Positioned(
                      top: 8.0,
                      right: 8.0,
                      child: IconButton(
                        icon: Icon(Icons.delete_rounded, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            removeFromSavedNews(savedNews[index]);
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
