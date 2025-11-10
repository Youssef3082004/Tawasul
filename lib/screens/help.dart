// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters

import 'package:flutter/material.dart';
import 'package:tawasul/constants.dart';
import 'package:tawasul/widget/enddrawer.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Constants cons = Constants(context: context);
    Color primary = Colors.white;
    Color borderDark = cons.Container_borderColor;
    Color surfaceDark = cons.Container_fillColor;
    const Color grayText = Colors.white54;

    final List<Map<String, String>> faqs = [
  {
    'question': 'How does Tawasul detect emotions?',
    'answer':'Tawasul uses advanced AI models that analyze both text and facial expressions to understand the emotions behind your words and images.'
  },
  {
    'question': 'Why is emotion analysis important?',
    'answer':'By identifying your emotional patterns, Tawasul helps you gain deeper self-awareness and avoid misunderstandings in daily communication.'
  },
  {
    'question': 'Can Tawasul analyze emotions from images?',
    'answer':'Yes. You can upload a photo, and Tawasul will detect the dominant emotion by analyzing facial expressions using computer vision techniques.'
  },
  {
    'question': 'Is my data safe and private?',
    'answer':'Absolutely. All emotional analyses are processed securely, and your personal data is never shared or stored without your consent.'
  },
  {
    'question': 'Can I track my emotional history?',
    'answer':'Yes. Tawasul provides a timeline of your emotional records, allowing you to reflect on your progress and emotional trends over time.'
  },
  {
    'question': 'Does Tawasul require an internet connection?',
    'answer':'Most features work offline, but some advanced AI analyses, especially image-based ones, may require an active internet connection.'
  },
  {
    'question': 'Can Tawasul help me improve communication?',
    'answer':'Definitely. By recognizing the tone and emotion in your messages, Tawasul suggests more empathetic ways to express yourself and understand others.'
  },
  
];
    AppBar page_appbar = AppBar(title: Text("Help & Support"),leading: IconButton(icon: Icon(Icons.menu,color: Colors.white,),onPressed: () => _scaffoldKey.currentState!.openDrawer()),scrolledUnderElevation: 0);

    return Scaffold(key: _scaffoldKey,appBar: page_appbar,drawer: AppDrawer(),
      backgroundColor: cons.main_color,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
             
              Column(
                children: faqs
                    .map(
                      (faq) => Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: borderDark),
                          ),
                        ),
                        child: ExpansionTile(
                          leading: Icon(Icons.help_outline_sharp,color: cons.SecondColor,),
                          collapsedIconColor: primary,
                          iconColor: primary,
                          tilePadding: EdgeInsets.zero,
                          shape: Border(),
                          collapsedShape: Border(),
                          title: Text(
                            faq['question']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: primary,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  faq['answer']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: grayText,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  Text(
                    'Still need help?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: cons.SecondColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'If you couldn\'t find the answer to your question, our team is here to assist you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: grayText),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: surfaceDark,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderDark),
                    ),
                    child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.mail_outline, color: cons.SecondColor),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email Support',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Tawasul.app@gmail.com',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: grayText,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                    
                  )
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

