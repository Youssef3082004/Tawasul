import 'package:flutter/material.dart';
import 'package:tawasul/constants.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    Constants cons = Constants(context: context);
    DrawerHeader drawerHeader = DrawerHeader(decoration: BoxDecoration(color: cons.main_color),child: Identity());

    List<Widget> pages = [drawerHeader,
      Card(child: page_listtile(context: context, icon: Icons.description, page_name: "Notes",desc: "Save Your Ideas here", route_name: "/notes"),color: cons.main_color,shadowColor:cons.Container_fillColor ,),
      Card(child: page_listtile(context: context, icon: Icons.psychology_alt, page_name: "Thoughts",desc: "Understand your mood better", route_name: "/thoughts"),color: cons.main_color,shadowColor:cons.Container_fillColor ,),
      Card(child: page_listtile(context: context, icon: Icons.camera_alt, page_name: "Camera",desc: "Pictures speak beyond words", route_name: "/camera"),color: cons.main_color,shadowColor:cons.Container_fillColor ,)


    ];

    ListView Elements = ListView(children: pages,padding: EdgeInsets.zero,); 
    return Drawer(child: Elements,backgroundColor: cons.main_color,);
  }


  ListTile page_listtile({required BuildContext context,required IconData icon,required String page_name,required String desc ,required String route_name}){
    
    Icon Leading_icon = Icon(icon,color: Color(0xff157fec),size: 30,);
    Icon trailing_icon = Icon(Icons.arrow_forward_ios_rounded,color: Color(0xff157fec));
    Text title = Text(page_name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15));
    Text subtitle = Text(desc,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w700,fontSize: 11));


   return ListTile(leading:Leading_icon ,trailing: trailing_icon,title:title ,subtitle: subtitle,
            onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, route_name);}
          );
  }
}