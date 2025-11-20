import 'package:flutter/material.dart';
import 'package:hw1mobile/screens/home-page.dart';
//الاسم:رامي شيخ
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complete Form Example',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,  
    );
  }
}