import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GalleryDataPage extends StatefulWidget {
  String keyword;
  GalleryDataPage(this.keyword);
  @override
  _galleryDataPageState createState() => _galleryDataPageState();
}

class _galleryDataPageState extends State<GalleryDataPage> {
  int currentPage = 1;
  int size = 10;
  List<dynamic> hits = [];
  var galleryData;
  int totalPages=1;
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.keyword}, Page  ${currentPage}/${totalPages}"),
          backgroundColor: Colors.blue,
        ),
        body: (galleryData == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: (galleryData == null ? 0 : hits.length),
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                                child: Text(
                              hits[index]['tags'],
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Image.network(
                              hits[index]['webformatURL'],
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              )));
  }

  void getData() {
    String url =
        "https://pixabay.com/api/?key=16059716-652b206c893c138de6d76d3c1&q=${widget.keyword}&page=${currentPage}&per_page=${size}";
    http.get(url).then((resp) {
      setState(() {
        galleryData = json.decode(resp.body);
        hits.addAll(galleryData['hits']);
        if (galleryData['totalHits'] % size == 0)
          totalPages = galleryData['totalHits'] ~/ size;
        else
          totalPages = 1 + ((galleryData['totalHits'] / size).floor());
        print(hits);
        print(totalPages);
      });

    }).catchError((err) {
      print(err);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages){
          currentPage++;
        this.getData();
      }}
    });
  }

  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();

  }
}
