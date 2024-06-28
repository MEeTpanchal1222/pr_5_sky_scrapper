import 'package:flutter/material.dart';
import 'package:pr_5_sky_scrapper/provider/provider.dart';
import 'package:pr_5_sky_scrapper/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => WeatherProvider(),)
    ],
      child: const MyApp()));

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
        "/" :(context) => SplashScreen();
        "home":(context) => HomeScreen(),
        // "home":(context) => home_screen(),
        //"serach":(context) => WeatherScreen(),
      },

    );
  }
}
