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
  // Separate state variables for like and save
  bool isLiked = false;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    // Initialize the saved state based on whether the article is already in savedNews
    isSaved = savedNews.contains(widget.article);
  }

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
          // Image that takes 60% of the card height
          if (hasValidUrl)
            CachedNetworkImage(
              imageUrl: imageUrl!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.image, size: 100),
            )
          else
            Icon(Icons.image, size: 100),

          // Headline
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.article['title'] ?? 'No Title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(widget.article['description'] ?? 'No Description'),
          ),

          // Icons Row
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Like icon
                IconButton(
                  icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
                  color: isLiked ? Colors.red : Colors.black,
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                      // Handle like logic here, if necessary
                    });
                  },
                ),
                // Comment icon
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    // Implement comment functionality
                  },
                ),
                // Share icon
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    // Implement share functionality
                  },
                ),
                // Save icon
                IconButton(
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: isSaved ? Colors.black : null,
                  ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
