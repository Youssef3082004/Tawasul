import "package:flutter/material.dart";
import 'package:tawasul/constants.dart';
import 'package:tawasul/database.dart';
import 'package:tawasul/widget/enddrawer.dart';
import 'package:tawasul/widget/note_widget.dart';
import 'package:tawasul/widget/CustomWidget.dart';




class Note extends StatefulWidget{

  const Note({super.key});

  @override
  State<Note> createState() => _Home();

} 


class _Home extends State<Note>{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final dbHelper = DatabaseHelper();
  final List<String> selectedEmotions = ["All"];
  List<Map<String, dynamic>> notes = [];

  // final List<String> emotions = ["All","Happy","Love","Anger","Sadness","Surprise","Fear"];
  // {id: 9, title: gggggg, content: ggggggggggg, date: 2025-11-05T01:57:19.551640, contentState: happy}



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
  void initState() {
    super.initState();
    loadNotes();
  }

  @override
  Widget build(BuildContext context){
    Constants cons = Constants(context: context);

    
    //! ==================================================================== Appbar =============================================    
    PopupMenuButton h =  PopupMenuButton(icon: Icon(Icons.more_vert, color: Colors.white),color: cons.main_color.withValues(alpha: 0.9),onSelected: (value)=>notes.isEmpty? null: PopupMenuButtonfunction(value),borderRadius: BorderRadius.circular(20),
    itemBuilder: (context) =>[PopupMenuItem(value: 1,child: Row(children: [Icon(Icons.delete, color: Colors.white),Text("Clear Notes",style: TextStyle(color: Colors.white)),],spacing: 10,),)]);

    AppBar page_appbar = AppBar(title: Text("Notes"),leading: IconButton(icon: Icon(Icons.menu,color: Colors.white,),onPressed: () => _scaffoldKey.currentState!.openDrawer()),actions: [h],scrolledUnderElevation: 0);

    //! ==================================================================== Statisticss class Widget =============================================
    ListView chipList = ListView(scrollDirection: Axis.horizontal,children: emotions.map((Map emotion) => Multiselected(emotion)).toList());

    //! ==================================================================== Statisticss class Widget =============================================
    Iterable<NoteWidget> Notes = notes.map((Map Element) => NotesBuilder(Element));
    Column Notes_Column = Column(children: [...Notes],spacing: 10,verticalDirection: VerticalDirection.up,);
    FloatingActionButton Add_button = FloatingActionButton(onPressed: ()=> Navigator.pushNamedAndRemoveUntil(context, "/thoughts", (route) => false),child: Icon(Icons.add,color: Colors.white),backgroundColor: Color(0xff157fec),);
    //! ==================================================================== Controls ===================================================
    Padding IdentityWidget = Padding(padding: EdgeInsets.only(top: cons.screen_height/5.0),child: Identity(ImagePath: "assets/images/Notes.gif",Description: "All your notes, neatly organized with easy emotion filtering.",),);

    //! ==================================================================== Controls ===================================================

    Column controls = Column(children: [SizedBox(child: chipList,height: 50),Notes.isEmpty? IdentityWidget:Notes_Column],mainAxisAlignment: MainAxisAlignment.center,spacing: 20,);
    Container main_app = Container(child: SingleChildScrollView(child: controls,scrollDirection: Axis.vertical,),padding: EdgeInsets.only(left: 5,right: 5),height: cons.screen_height,);
    return Scaffold(key: _scaffoldKey,body: main_app,appBar: page_appbar,backgroundColor: cons.main_color,drawer: AppDrawer(),floatingActionButton: Add_button,);

  }

 
 Widget Multiselected(Map emotion){
    final bool isSelected = selectedEmotions.contains(emotion["name"]);
    final Color iconColor = isSelected ? Colors.white : emotion["color"];

    ChoiceChip button = ChoiceChip(label: Text(emotion["name"]), avatar: Icon(emotion["icon"],color: iconColor),showCheckmark: false,
    selected: isSelected,selectedColor:Color(0xff137fec),surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,selectedShadowColor: Colors.transparent,backgroundColor: Color(0xff17202f),
    labelStyle: TextStyle(color:  Colors.white),side: BorderSide(color: Colors.transparent,width: 4),
    onSelected: (selected) => SelectedEmotions(selected, emotion["name"]));

    return Padding(child: button,padding: const EdgeInsets.symmetric(horizontal: 4.0));
    
  
  }

  
  

  void SelectedEmotions(bool selected, String emotion) async {
  setState(() {
    if (selected && emotion != "All") {
      selectedEmotions.remove("All");
      selectedEmotions.add(emotion);
    } else if (selected && emotion == "All") {
      selectedEmotions.clear();
      selectedEmotions.add("All");
    } else if (selectedEmotions.length > 1) {
      selectedEmotions.remove(emotion);
    }
  });

  await filterNotes();
}

  
  Future<void> filterNotes() async {
    if (selectedEmotions.contains("All")) {
      final data = await dbHelper.getNotes(); 
      setState(() => notes = data);
    } 
    else {
      final data = await dbHelper.getNotesByCategory(selectedEmotions);
      setState(() => notes = data);
    }
  }



  NoteWidget NotesBuilder(Map Element){
    if (Element["contentState"] == "Happy"){
      return NoteWidget(Iconcolor:Colors.yellow,leadingicon: Icons.sentiment_very_satisfied_outlined,NoteData: Element,);
    }
    else if (Element["contentState"] == "Love"){
      return NoteWidget(Iconcolor:Colors.redAccent,leadingicon: Icons.favorite,NoteData: Element);
    }

    else if (Element["contentState"] == "Anger"){
      return NoteWidget(Iconcolor:Colors.red,leadingicon: Icons.sentiment_very_dissatisfied,NoteData: Element);
    }

    else if (Element["contentState"] == "Sadness"){
      return NoteWidget(Iconcolor:Colors.lightBlue,leadingicon: Icons.sentiment_dissatisfied,NoteData: Element);
    }

    else if (Element["contentState"] == "Surprise"){
      return NoteWidget(Iconcolor:Colors.orange,leadingicon: Icons.emoji_objects,NoteData: Element);
    }

    else if (Element["contentState"] == "Fear"){
      return NoteWidget(Iconcolor:Colors.purple,leadingicon: Icons.sentiment_neutral,NoteData: Element);
    }

    
    return NoteWidget(Iconcolor:Colors.amber,leadingicon: Icons.work,NoteData: Element);

  }

    
  
  Future<void> loadNotes() async {
    final data = await dbHelper.getNotes();
    setState(() => notes = data);
  }



  Future<void> _DeleteNotes() async {
    await dbHelper.deleteNotes();
    setState(() => notes = []);
  }


  void PopupMenuButtonfunction(int value) async{
    if (value == 1) {
      if(!mounted) return;
      Customwidgets.ShowAsesomeDialog(context: context, title: "Erase Everything?", message: "Everything in your notes will be lost. Do you wish to continue?", 
          Function: () async  {
            await _DeleteNotes();
            if(!mounted) return;
            Customwidgets.ShowAwesomeSnackbar(context: context, title: "Clear All Notes", message: "All notes have been successfully removed!");
          } 
        );

    } 
   
  }

                      



 } 


  




