import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/galleryDataPage.dart';
import 'dart:convert';
class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  String keyword = "";
  TextEditingController textEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(keyword),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(hintText: "Please insert a place"),
                style: TextStyle(fontSize: 22),

                onChanged: (value) {
                  setState(() {
                    this.keyword = value;
                  });
                },
                onSubmitted: (value){
                  this.keyword=value;
                  Navigator.push(context, MaterialPageRoute(builder : (context)=>GalleryDataPage(this.keyword)));
                  textEditingController.text="";
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: RaisedButton(
              child: Text(
                "Get Images",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder : (context)=>GalleryDataPage(keyword)));
                textEditingController.text="";
              },
              color: Colors.blue,
              padding: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
