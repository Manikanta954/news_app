import 'package:flutter/material.dart';

class SavedNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved News'),
      ),
      body: Center(
        child: Text('Your Saved News'),
      ),
    );
  }
}
