import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final dynamic article;

  NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        leading: article['urlToImage'] != null
            ? CachedNetworkImage(
                imageUrl: article['urlToImage'],
                width: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.image, size: 100),
              )
            : Icon(Icons.image, size: 100),
        title: Text(article['title'] ?? 'No Title'),
        subtitle: Text(article['description'] ?? 'No Description'),
      ),
    );
  }
}
