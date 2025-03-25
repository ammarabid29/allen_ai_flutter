import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Allen"),
        leading: Icon(Icons.menu),
        centerTitle: true,
      ),
      // body: Placeholder(),
    );
  }
}
