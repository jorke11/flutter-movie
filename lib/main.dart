import 'package:flutter/material.dart';
import 'package:flutter_movie/src/pages/detail_page.dart';
import 'package:flutter_movie/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/': (context)=>HomePage(),
        'detail': (context)=>DetailPage(),
      },
    );
  }
}