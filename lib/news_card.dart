import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'saved_news_page.dart';

class NewsCard extends StatefulWidget {
  final dynamic article;

  NewsCard({required this.article});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    // Check if the URL is valid
    String? imageUrl = widget.article['urlToImage'];
    bool hasValidUrl = imageUrl != null && imageUrl.isNotEmpty;

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hasValidUrl
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.image, size: 100),
                )
              : Icon(Icons.image, size: 100), // Fallback if image URL is invalid
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.article['title'] ?? 'No Title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(widget.article['description'] ?? 'No Description'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(isSaved ? Icons.favorite : Icons.favorite_border),
                color: isSaved ? Colors.red : Colors.black,
                onPressed: () {
                  setState(() {
                    isSaved = !isSaved;
                    if (isSaved) {
                      addToSavedNews(widget.article);
                    } else {
                      removeFromSavedNews(widget.article);
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  // Implement share functionality
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
