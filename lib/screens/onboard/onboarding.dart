import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import "package:tawasul/constants.dart";
import 'package:tawasul/screens/onboard/onboarding_screen.dart';




class Onboarding extends StatefulWidget{

  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _Onboarding();
}



class _Onboarding extends State<Onboarding>{

  late final PageController _pageController;
  final pages = [
    Onboarding_screen(Title: "Enhance Your Well-being", Subtitle:"Discover insights into your emotional state through your words and expressions. Powered by advanced AI for personalized understanding." , image: "assets/images/onboarding1.png"),
    Onboarding_screen(Title: "Understand Emotions Through Words", Subtitle:"Our app analyzes your text to reveal emotional patterns, helping you gain deeper self-awareness and improve your mental well-being." , image: "assets/images/onboarding2.png"),
    Onboarding_screen(Title: "Understand Your Emotions Visually", Subtitle:"Our app analyzes facial expressions from your photos to provide emotional insights, helping you better understand your feelings." , image: "assets/images/onboarding3.png"),
    Onboarding_screen(Title: "Monitor Your Emotions with Graphs", Subtitle:'See how your emotions change over time and uncover your unique emotional trends' , image: "assets/images/onboarding4.png",button: true),
  ];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Constants cons = Constants(context: context);

    //! ====================================================== PageView ==========================================

    PageView pages_view = PageView(controller: _pageController,children: pages,onPageChanged: (index) => setState(() => _selectedIndex = index ));
    SmoothPageIndicator pages_widget =  SmoothPageIndicator(controller: _pageController,count:pages.length,effect:  SwapEffect(dotHeight: 13,dotWidth: 13,activeDotColor: Color(0xff137fec),dotColor: Color(0xff475569)));    
    //! ====================================================== interface body ==========================================

    Stack controls = Stack(alignment: AlignmentGeometry.center,children: [Positioned.fill(child: pages_view),Positioned(child:pages_widget,bottom: 100)]);
    Container main_body = Container(color: cons.main_color,child: controls);
    return Scaffold(body: main_body);

  }



}