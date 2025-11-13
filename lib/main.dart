import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawasul/functions.dart';
import 'package:tawasul/provider/ThoughtsProvider.dart';
import 'package:tawasul/screens/Thoughts.dart';
import 'package:tawasul/screens/camera.dart';
import 'package:tawasul/screens/emograph.dart';
import 'package:tawasul/screens/notes.dart';
import 'package:tawasul/screens/aboutus.dart';
import 'package:tawasul/screens/help.dart';
import 'package:tawasul/screens/onboard/welcome.dart';
import 'package:tawasul/screens/onboard/onboarding.dart';
import 'package:tawasul/provider/theme.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

const apiKey = 'AIzaSyDiZVuBtz08mZQx7hMWjEkARCTKTFAAd8Y';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await DatabaseHelper().resetDatabase(); // delete old DB
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: apiKey, enableDebugging: true);
  final loginornot = await PublicFunction.loadUserState();

  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (context) => Thoughtsprovider())],child: MyApp(loginornot: loginornot,)));
}

class MyApp extends StatelessWidget {
  final String loginornot;
  const MyApp({super.key,required this.loginornot});

  @override
  Widget build(BuildContext context) {

    Map<String, Widget Function(BuildContext)> routes = {
      "/":(context) => Welcome(),
      "/onboarding": (context) => Onboarding(),
      "/thoughts":(context) => Thoughts(),
      "/camera": (context) => Camera(),
      "/notes": (context) => Note(),
      "/emograph": (context) => Emograph(),
      "/aboutus": (context) => AboutUs(),
      "/help":(context) => HelpSupport(),


    };

    
    return MaterialApp(debugShowCheckedModeBanner: false,
    initialRoute:loginornot == "Yes"? "/notes" :"/",
      title: "Tawasul",routes:routes,
      theme: lightmode,
      
    );
  }
}