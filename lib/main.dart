import 'package:flutter/material.dart';
import 'package:news_app/screens/HomePage.dart';


void main() {
  runApp( NewsApp());
}
class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //textTheme:,
      ),
      home: HomePage(),
    );
  }
}
