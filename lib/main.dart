import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/home_page/home_page.dart';
import 'utils/app_styles/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final String appTitle = "Shopping List";

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: appTitle,
        theme: AppTheme.darkTheme,
        home: HomePage(title: appTitle,),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
