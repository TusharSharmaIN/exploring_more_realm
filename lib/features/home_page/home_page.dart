import 'package:flutter/material.dart';

import '../item_list_page/item_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: ItemListPage(),
      ),
    );
  }
}
