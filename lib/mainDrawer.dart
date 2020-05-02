import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/QRScan.dart';
import './quiz.dart';
import './gallery.dart';
import './weather.dart';
import './camera.dart';
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[

          DrawerHeader(
            decoration : BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blue,Colors.white])
            ),
            child: CircleAvatar(
              radius : 50,backgroundImage: NetworkImage('https://flutter.dev/images/catalog-widget-placeholder.png'),
            ),
          ),

          ListTile(
            title:Text('Quiz',style:TextStyle(fontSize: 22)),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder:(context)=>Quiz()));

            },
          ),
          Divider(color: Colors.blue),
          ListTile(
            title:Text('Weather',style:TextStyle(fontSize: 22)),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder:(context)=>Weather()));
            },
          ),
          Divider(color: Colors.blue),
          ListTile(
            title:Text('Gallery',style:TextStyle(fontSize: 22)),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder:(context)=>Gallery()));
            },
          ),
          Divider(color: Colors.blue),
          ListTile(
            title:Text('Camera',style:TextStyle(fontSize: 22)),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder:(context)=>CameraPage()));
            },
          ),
          Divider(color: Colors.blue),
          ListTile(
            title:Text('QR Scan',style:TextStyle(fontSize: 22)),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder:(context)=>QRScan()));
            },
          ),
        ],
      ),

    );
  }
}
