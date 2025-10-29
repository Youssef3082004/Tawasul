import 'package:flutter/material.dart';
import 'package:tawasul/screens/Thoughts.dart';
import 'package:tawasul/screens/camera.dart';
import 'package:tawasul/screens/onboard/welcome.dart';
import 'package:tawasul/screens/onboard/onboarding.dart';
import 'package:tawasul/provider/theme.dart';

void main() {
  // runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (context) => Mode()),ChangeNotifierProvider(create: (context) => Language())],child: MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    Map<String, Widget Function(BuildContext)> routes = {
      "/":(context) => Welcome(),
      "/onboarding": (context) => Onboarding(),
      "/thoughts":(context) => Thoughts(),
      "/camera": (context) => Camera()
    };

    
    return MaterialApp(debugShowCheckedModeBanner: false,
    initialRoute: "/",
      title: "Tawasul",routes:routes,
      theme: lightmode,
      
    );
  }
}