import 'package:flutter/material.dart';
import 'package:pr_5_sky_scrapper/view/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      routes: {
        //"/" :(context) => slashscreen();
        "home":(context) => home_screen(),
      },
    );
  }
}