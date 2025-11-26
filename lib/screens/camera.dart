import 'dart:io';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:tawasul/constants.dart';
import 'package:tawasul/functions.dart';
import 'package:tawasul/widget/enddrawer.dart';
import 'package:tawasul/widget/camera_widget.dart';
import 'package:tawasul/widget/CustomWidget.dart';




class Camera extends StatefulWidget{
  const Camera({super.key});

  @override
  State<Camera> createState() => _Home();

} 


class _Home extends State<Camera>{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool Analyzed = false;
  bool showstat = false;
  bool Loading = false;
  File? fileimage;
  List<dynamic> Prediction = [];
  String Advice = '';
  


  @override
  Widget build(BuildContext context){
    Constants cons = Constants(context: context);

    //! ==================================================================== Appbar =============================================
    IconButton ClearButton = IconButton(onPressed: Analyzed && showstat?  ()=> Clear():null, icon: Icon(Icons.cancel),disabledColor: Colors.grey,color: Colors.white);

    AppBar page_appbar = AppBar(title: Text("Camera"),leading: IconButton(icon: Icon(Icons.menu,color: Colors.white,),onPressed: () => _scaffoldKey.currentState!.openDrawer()),scrolledUnderElevation: 0,actions: [ClearButton],);

    //! ==================================================================== Statisticss class Widget =============================================
    StatisticssWidget class_Stats = StatisticssWidget(Prediction: Prediction,Advice: Advice,);

    //! ==================================================================== upload Camera Container =============================================
    Column camera_controls = Column(children: [Icon(Icons.camera_alt_outlined,size: 50,color: Colors.white),Text("Upload Image or take photo",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 18),)],mainAxisAlignment: MainAxisAlignment.start,spacing: 0);
    BoxDecoration widget_decor = BoxDecoration(border: Border.all(color: cons.Container_borderColor,width: 3),color: cons.Container_fillColor,borderRadius: BorderRadius.circular(12));
    Container camera_container =  Container(child: camera_controls,padding: EdgeInsets.all(50),decoration: widget_decor,width: cons.screen_width,);
    InkWell camera_Button =  InkWell(child: camera_container,onTap:()=> showPickerDialog(context) );

    //! ==================================================================== uploaded Image =============================================
    Center UploadedImage = Center(child: fileimage == null? SizedBox.shrink() : ChoosedImage(fileimage: fileimage));

    //! ==================================================================== Controls ===================================================
    Padding IdentityWidget = Padding(padding: EdgeInsets.only(bottom: 15),child: Identity(ImagePath: "assets/images/Image upload.gif",Description: "Upload a photo and instantly get an emotion label based on its visual mood.",),);

    //! ==================================================================== loading ===================================================
    LoadedCircle loading = LoadedCircle(TextUnderLoad: "Please Wait...",);

    //! ==================================================================== Analyze Button =============================================
    FilledButton analyze_button = FilledButton(onPressed: Analyzed? () => ClassifyImage():null, child: Text("Analyze",style: TextStyle(fontWeight: FontWeight.w700),),style: cons.Button_style);

    //! ==================================================================== Controls ===================================================
    Column controls = Column(mainAxisAlignment: MainAxisAlignment.start,spacing:20,children: [camera_Button,UploadedImage,SizedBox(child: analyze_button,width: cons.screen_width - 30,),
        if (Loading) 
            loading                  
        else if (showstat) 
            class_Stats             
        else 
            IdentityWidget          
          ]
    );

    Container main_app = Container(child: SingleChildScrollView(child: controls),padding: EdgeInsets.only(left: 5,right: 5));
    return Scaffold(key: _scaffoldKey,body: main_app,appBar: page_appbar,backgroundColor: cons.main_color,drawer: AppDrawer());

  }


  Future<void> ClassifyImage() async {
      if (fileimage == null) return;
      if (!await PublicFunction.hasInternet()) {
        if (!mounted) return;
        Customwidgets.ShowAwesomeSnackbar(context: context,title: "Oops!",message: "Please check your internet connection!",isError: true);
        return;
      }

      setState(() {
        Loading = true;   
        showstat = false; 
      });

      try {
        String? adviceMessage; 
        List<dynamic>? results = await PublicFunction.getImageEmotion(fileimage!); 

        if (results.isNotEmpty) {
          adviceMessage = await PublicFunction.GiminiAdvice(usernote: results[0]["label"]);
        }


        setState(() {
          Loading = false; 
          if (results.isNotEmpty) {
            Prediction = results; 
            showstat = true;
            Advice = adviceMessage!;
          }  
          else {
            showstat = false;
            Customwidgets.ShowAwesomeSnackbar(context: context, title: "No Faces!", message: "No faces were detected in the uploaded file, Please Try Again",isError: true);
          }
        });
        
      } catch (e) {
        setState(() {
          Loading = false; 
          showstat = false;
        });
        print("Error: $e");
      }
    }


  Future<void> _getimage(ImageSource Source) async{
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: Source);
    if (photo != null){
        setState(() { 
          fileimage = File(photo.path); 
          Analyzed = true;
          });
      }
    }
  

    void showPickerDialog(BuildContext context) {
    Constants cons = Constants(context: context);
    ListTile photo = ListTile(leading: const Icon(Icons.camera_alt,color: Color(0xff157fec),),title: Text('Take Photo',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15),),onTap:() {Navigator.of(context).pop();_getimage(ImageSource.camera);},);
    ListTile gallery = ListTile(leading: const Icon(Icons.photo_library,color:Color(0xff157fec)),title: Text('Choose from Gallery',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15),),onTap: () {Navigator.of(context).pop();_getimage(ImageSource.gallery);});
    Wrap Controls = Wrap(children: [photo,gallery]);
    showModalBottomSheet(backgroundColor: cons.main_color,context: context,builder: (BuildContext context) => SafeArea(child: Controls));
  }


  void Clear() => setState(() {
    Analyzed = false;
    showstat = false;
    Loading = false;
    fileimage = null;
  });

}