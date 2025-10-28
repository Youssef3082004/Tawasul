import "package:flutter/material.dart";

//! ===================================================== Light Theming =========================================== 


ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(backgroundColor: Color(0xff151c22),centerTitle: true,titleTextStyle: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w300,fontFamily: "Inter_ExtraBold"),),

  inputDecorationTheme:InputDecorationTheme(filled: true,fillColor: Color(0xff27272a),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 3,color: Color(0xff7d7b7d)),borderRadius: BorderRadius.circular(15)),
  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 3,color: Color(0xff7d7b7d)),borderRadius: BorderRadius.circular(15)),
  hintStyle: TextStyle(color: Color(0xff3d3d3d),fontSize: 20,fontFamily: "inter",fontWeight: FontWeight.bold),
  labelStyle: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "inter",fontWeight: FontWeight.w800),
  ),
  iconButtonTheme: IconButtonThemeData(style:ButtonStyle(iconColor: WidgetStateProperty.all<Color>(Colors.black))),

  pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android:FadeForwardsPageTransitionsBuilder(backgroundColor: Colors.black)})
);






