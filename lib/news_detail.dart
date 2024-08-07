// lib/news_detail.dart

import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final dynamic article;

  NewsDetail({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: article['urlToImage'] != null
              ? Image.network(
                  article['urlToImage'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('Image load error: $error'); // Debug image loading issues
                    return Center(child: Text('Image failed to load'));
                  },
                )
              : Center(child: Text('No image available')),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article['title'] ?? 'No Title',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: 8.0),
                Text(
                  article['description'] ?? 'No Description',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
