// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters
import 'package:flutter/material.dart';
import 'package:tawasul/constants.dart';
import 'package:tawasul/widget/enddrawer.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Constants cons = Constants(context: context);


    Color primary = cons.SecondColor;
    Color backgroundDark = cons.main_color;
    const Color textPrimary = Colors.white;
    const Color textPrimary80 = Colors.white54;
    AppBar page_appbar = AppBar(title: Text("About us"),leading: IconButton(icon: Icon(Icons.menu,color: Colors.white,),onPressed: () => _scaffoldKey.currentState!.openDrawer()),);

    Image Logo_image = Image.asset("assets/images/logo.png",fit: BoxFit.cover,);
    SizedBox image_container = SizedBox(child: Logo_image,width: 200,);
    Text Appliation_name = Text("Tawasul",style: TextStyle(fontSize: 30,color: Colors.white,fontFamily: "Pac"));
    Column title_column = Column(children: [image_container,Appliation_name],spacing: 0,);


    return Scaffold(appBar: page_appbar,key: _scaffoldKey,drawer: AppDrawer(),
      backgroundColor: backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                           
                            title_column,
                            const SizedBox(height: 15),
                            
                            Text(
                              'To decode the language of feelings, turning every emotion into a path of self-understanding',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: textPrimary80,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'OUR MISSION: WHY IT BEGAN',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Tawasul wasn't born in silence; it was born from the voice of emotion to reconnect hearts in the digital age",
                            style: TextStyle(
                              fontSize: 14,
                              color: textPrimary80,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'OUR GUIDING PRINCIPLES',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: cons.SecondColor,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.menu_book, color: primary),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'AUTHENTICITY FIRST',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Every emotion is carefully analyzed to reflect the truth behind every word and expression',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: textPrimary80,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.auto_awesome, color: primary),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'TIME-BREAKING INTERACTION',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Through AI and empathy, we translate emotion into awareness, turning words into connection',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: textPrimary80,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.person_pin_circle, color: primary),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'A JOURNEY DESIGNED FOR YOU',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Every feature is shaped to bring empathy to your screen and awareness to your world',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: textPrimary80,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

