import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:tawasul/constants.dart';
import 'package:tawasul/functions.dart';
import 'package:tawasul/provider/ThoughtsProvider.dart';
import 'package:tawasul/widget/enddrawer.dart';
import 'package:tawasul/widget/thoughts_widget.dart';
import 'package:tawasul/widget/CustomWidget.dart';


class Thoughts extends StatefulWidget{
  const Thoughts({super.key});

  @override
  State<Thoughts> createState() => _Home();
} 


class _Home extends State<Thoughts>{

  late Thoughtsprovider thoughtsProvider;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? Emotion;
  double ClassPercentage = 0.0;
  String? Advice;
  bool Analyzed = false;
  bool isloading = false;
  

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    thoughtsProvider = Provider.of<Thoughtsprovider>(context, listen: false);
  }

  @override
  void dispose() {
    thoughtsProvider.ResetAll();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    Constants cons = Constants(context: context);

    //! ==================================================================== Appbar =============================================
    AppBar page_appbar = AppBar(title: Text("Thoughts"),leading: IconButton(icon: Icon(Icons.menu,color: Colors.white,),onPressed: () => _scaffoldKey.currentState!.openDrawer()),scrolledUnderElevation: 0);

    //! ==================================================================== page Title & Page subtitle =============================================
    Text title = Text("How are you Feeling?",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Inter_ExtraBold"),);
    Text subtitle = Text("write it down",textAlign: TextAlign.start,style:TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w500,fontSize: 15),);
    Column Texts = Column(children: [title,subtitle],crossAxisAlignment: CrossAxisAlignment.start);
    Row ggg = Row(children: [Texts],mainAxisAlignment: MainAxisAlignment.start,);

    //! ==================================================================== Note Widget =============================================
    ThoughtsTextfeild Note_container = ThoughtsTextfeild();

    //! ==================================================================== Controls ===================================================
    Identity IdentityWidget = Identity(ImagePath: "assets/images/Add notes.gif",Description: "Write your note first, and get an instant emotion tag based on your text",);

    //! ==================================================================== Analyze Button =============================================
    Consumer analyze_button = Consumer<Thoughtsprovider>(
      builder: (context, provider, child) {
        return FilledButton(onPressed:provider.isFillText? ()=> analyzeButtonFunc(provider) : null, child: Text("Analyze",style: TextStyle(fontWeight: FontWeight.w700),),style: cons.Button_style);
      },
    );

    //! ==================================================================== Controls ===================================================
    Column controls = Column(children: [ggg,Note_container,SizedBox(child: analyze_button, width: cons.screen_width - 30,),Analyzed && Provider.of<Thoughtsprovider>(context).isAnalyzed? HomeWidget(ClassPercentage:ClassPercentage ,Emotion: Emotion,Advice: Advice,): isloading? Padding(padding: const EdgeInsets.only(top: 40),child: LoadedCircle(TextUnderLoad: "Please Wait...",),): IdentityWidget,SizedBox(height: 20,)],mainAxisAlignment: MainAxisAlignment.start,spacing: 20,);
    Container main_app = Container(child: SingleChildScrollView(child: controls),padding: EdgeInsets.only(left: 5,right: 5));
    return Scaffold(key: _scaffoldKey,body: main_app,appBar: page_appbar,backgroundColor: cons.main_color,drawer: AppDrawer());

  }



  void analyzeButtonFunc(Thoughtsprovider provider) async {
    if (!await PublicFunction.hasInternet()) {
      if (!mounted) return;
      Customwidgets.ShowAwesomeSnackbar(context: context,title: "Oops!",message: "Please check your internet connection!",isError: true,);
      return;
    }

    setState(() {Analyzed = false;isloading = true;});

    try {
      final note = provider.NoteText;
      Map<String, dynamic> emotion = await PublicFunction.ClassifyText(UserNote: note);
      if (emotion.containsKey("Error")) {throw Exception(emotion["Error"]);}

      final advice = await PublicFunction.GiminiAdvice(usernote: note);

      provider.UpdateAdvice(advice);
      provider.UpdateEmotion(emotion["Emotion"]);

      setState(() {
        Advice = advice;
        Emotion = emotion["Emotion"];
        ClassPercentage = emotion["Percentage"];
        Analyzed = true;
        isloading = false;
      });

      provider.ToggleAnalyzed(true);

      } 
    catch (e) {
      if (!mounted) return;
      Customwidgets.ShowAwesomeSnackbar(context: context,title: "Error",message: "Something went wrong: $e",isError: true,);
      setState(() {isloading = false;Analyzed = false;});

      }
    }


}