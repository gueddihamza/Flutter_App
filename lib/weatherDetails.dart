import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';

class weatherDetails extends StatefulWidget {
  String city;
  weatherDetails(this.city);
  @override
  _weatherDetailsState createState() => _weatherDetailsState();
}

class _weatherDetailsState extends State<weatherDetails> {
  var weatherData;
  void initState() {
    super.initState();
    getData(widget.city);
  }

  void getData(String city) {
    print("Getting weather of " + city);
    String url =
        "http://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=9d6480c227693d97a6ef4b80fd715e6f&units=metric";
    http.get(url).then((resp) {
      setState(() {
        print(resp.body);
        this.weatherData = jsonDecode(resp.body);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather of ${widget.city}")),
      body: (weatherData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: (weatherData == null ? 0 : weatherData['list'].length),
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            (weatherData['list'][index]['weather'][0]['main'] ==
                                    'Rain'
                                ? BoxedIcon(
                                    WeatherIcons.rain,
                                    size: 35,
                                  )
                                : (weatherData['list'][index]['weather'][0]
                                            ['main'] ==
                                        'Clear'
                                    ? BoxedIcon(
                                        WeatherIcons.day_sunny,
                                        size: 35,
                                      )
                                    : (weatherData['list'][index]['weather'][0]
                                                ['main'] ==
                                            'Clouds'
                                        ? BoxedIcon(
                                            WeatherIcons.cloudy,
                                            size: 35,
                                          )
                                        : (weatherData['list'][index]['weather']
                                                    [0]['main'] ==
                                                'Thunderstorm'
                                            ? BoxedIcon(
                                                WeatherIcons.thunderstorm,
                                                size: 35,
                                              )
                                            : (weatherData['list'][index]
                                                            ['weather'][0]
                                                        ['main'] ==
                                                    'Snow'
                                                ? BoxedIcon(
                                                    WeatherIcons.snow,
                                                    size: 35,
                                                  )
                                                : BoxedIcon(
                                                    WeatherIcons.fog,
                                                    size: 35,
                                                  )))))),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${new DateFormat('E-dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(
                                        weatherData['list'][index]['dt'] * 1000000))}",
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white,fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${new DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(
                                        weatherData['list'][index]['dt'] * 1000000))} | ${weatherData['list'][index]
                                    ['weather'][0]
                                    ['main']}",
                                    style:
                                    TextStyle(fontSize: 22, color: Colors.white,fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          (weatherData['list'][index]['main']['temp'])
                                  .round()
                                  .toString() +
                              "°C",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
