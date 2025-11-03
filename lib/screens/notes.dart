import "package:flutter/material.dart";
import 'package:tawasul/constants.dart';
import 'package:tawasul/widget/enddrawer.dart';
import 'package:tawasul/widget/note_widget.dart';


class Note extends StatefulWidget{

  const Note({super.key});

  @override
  State<Note> createState() => _Home();

} 


class _Home extends State<Note>{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  final List<String> selectedEmotions = ["All"];

  // final List<String> emotions = ["All","Happy","Love","Anger","Sadness","Surprise","Fear"];



  final List<Map<String, dynamic>> emotions = [
    {"name": "All", "icon": Icons.all_inclusive, "color": Colors.blue},
    {"name": "Happy", "icon": Icons.sentiment_very_satisfied_outlined, "color": Colors.yellow},
    {"name": "Love", "icon": Icons.favorite, "color": Colors.pink},
    {"name": "Anger", "icon": Icons.sentiment_very_dissatisfied, "color": Colors.red},
    {"name": "Sadness", "icon": Icons.sentiment_dissatisfied, "color": Colors.lightBlue},
    {"name": "Surprise", "icon": Icons.emoji_objects, "color": Colors.orange},
    {"name": "Fear", "icon": Icons.sentiment_neutral, "color": Colors.purple},
  ];

  @override
  Widget build(BuildContext context){
    Constants cons = Constants(context: context);

    //! ==================================================================== Appbar =============================================
    AppBar page_appbar = AppBar(title: Text("Notes"),leading: IconButton(icon: Icon(Icons.menu,color: Colors.white,),onPressed: () => _scaffoldKey.currentState!.openDrawer()),);

    //! ==================================================================== Statisticss class Widget =============================================
    ListView chipList = ListView(scrollDirection: Axis.horizontal,children: emotions.map((Map emotion) => Multiselected(emotion)).toList());

    //! ==================================================================== Statisticss class Widget =============================================
    List<Widget> Notes = [
      NoteWidget(Title: "Today was a really good day",subtitle: "May 20, 2024",Iconcolor: Colors.white,leadingicon: Icons.abc,),
      NoteWidget(Title: "Feeling a bit down, not sure",subtitle: "May 20, 2024",Iconcolor: Colors.white,leadingicon: Icons.abc,),
      NoteWidget(Title: "The meeting was stressful",subtitle: "May 20, 2024",Iconcolor: Colors.white,leadingicon: Icons.abc,),
    
      
      
    ];
    
    Column Notes_Column = Column(children: [...Notes],spacing: 10);


    FloatingActionButton Add_button = FloatingActionButton(onPressed: ()=> Navigator.pushNamedAndRemoveUntil(context, "/thoughts", (route) => false),child: Icon(Icons.add,color: Colors.white),backgroundColor: Color(0xff157fec),);
    //! ==================================================================== Controls ===================================================
    Column controls = Column(children: [SizedBox(child: chipList,height: 50),Notes_Column],mainAxisAlignment: MainAxisAlignment.start,spacing: 20,);
    Container main_app = Container(child: SingleChildScrollView(child: controls,scrollDirection: Axis.vertical,),padding: EdgeInsets.only(left: 5,right: 5));
    return Scaffold(key: _scaffoldKey,body: main_app,appBar: page_appbar,backgroundColor: cons.main_color,drawer: AppDrawer(),floatingActionButton: Add_button,);

  }

 
 Widget Multiselected(Map emotion){
    final bool isSelected = selectedEmotions.contains(emotion["name"]);
    final Color iconColor = isSelected ? Colors.white : emotion["color"];

    ChoiceChip button = ChoiceChip(label: Text(emotion["name"]), avatar: Icon(emotion["icon"],color: iconColor),showCheckmark: false,selected: isSelected,selectedColor:Color(0xff137fec),
    labelStyle: TextStyle(color:  Colors.white),side: BorderSide(color: Colors.white,width: 2),backgroundColor: Color(0xff17202f),
    onSelected: (selected) => hala(selected, emotion["name"]));

    return Padding(child: button,padding: const EdgeInsets.symmetric(horizontal: 4.0));
    
  
  }

  

  void hala (bool selected,String emotion) => setState(() {
                          if (selected && emotion != "All") {
                            selectedEmotions.remove("All");
                            selectedEmotions.add(emotion);
                          }

                          else if (selected && emotion == "All"){
                            selectedEmotions.clear();
                            selectedEmotions.add("All");
                          }

                          else if (selectedEmotions.length > 1){ 
                          
                            selectedEmotions.remove(emotion);
                          }
                        });
                      



 } 


  




