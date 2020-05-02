import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/weatherDetails.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String city = "";
  TextEditingController textEditingController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(city),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(hintText: "Please Insert a city"),
                  style: TextStyle(fontSize: 22),
                  onChanged: (value) {
                    setState(() {
                      this.city = value;
                    });
                  },
                  onSubmitted:(value) {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => weatherDetails(city)));
                    textEditingController.text = "";
                  }
                ),
              ),
            ),
            Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>weatherDetails(city)));
                      textEditingController.text="";




                      
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text(
                      'Get Weather',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ))
          ],
        ));
  }
}
