import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final dynamic article;
  final Function(dynamic) onSaveArticle;

  NewsDetail({required this.article, required this.onSaveArticle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (article['urlToImage'] != null)
            Image.network(article['urlToImage']),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              article['title'] ?? 'No Title',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              article['description'] ?? 'No Description',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  onSaveArticle(article);
                },
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  // Add your share logic here
                },
              ),
              IconButton(
                icon: Icon(Icons.bookmark_border),
                onPressed: () {
                  onSaveArticle(article);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
