import 'package:flutter/material.dart';
import 'package:study_log/presentation/shell_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Log',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF0F2F5),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // アプリの最初の画面を ShellScreen に設定
      home: const ShellScreen(),
    );
  }
}
