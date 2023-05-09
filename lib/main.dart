import 'package:flutter/material.dart';

import 'features/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'List App',
      home: HomePage(
        title: 'Shopping List',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
