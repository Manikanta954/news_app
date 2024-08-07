import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Center(
        child: Text('Welcome to News App!'),
      ),
    );
  }
}
