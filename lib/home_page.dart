import 'package:flutter/material.dart';
import 'news_card.dart';
import 'news_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  List<dynamic> _news = [];

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _fetchNews() async {
    var news = await fetchNews();
    setState(() {
      _news = news;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required when using AutomaticKeepAliveClientMixin
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: _news.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchNews,
              child: ListView.builder(
                itemCount: _news.length,
                itemBuilder: (context, index) {
                  final article = _news[index];
                  return NewsCard(article: article);
                },
              ),
            ),
    );
  }
}
