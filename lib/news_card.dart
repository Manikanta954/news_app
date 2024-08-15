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
  bool isLiked = false;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    isSaved = savedNews.contains(widget.article);
  }

  @override
  Widget build(BuildContext context) {
    String? imageUrl = widget.article['image'];
    bool hasValidUrl = imageUrl != null && imageUrl.isNotEmpty;

    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasValidUrl)
            CachedNetworkImage(
              imageUrl: imageUrl!,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.image, size: 100),
            )
          else
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[300],
              child: Icon(Icons.image, size: 100),
            ),
          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.article['title'] ?? 'No Title',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Playwrite_CU',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.article['description'] ?? 'No Description',
              style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 91, 90, 90)
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
                  color: isLiked ? Colors.red : Colors.black,
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    // Implement comment functionality
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    // Implement share functionality
                  },
                ),
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
