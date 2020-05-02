import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File imageFile;
  VisionText visionTextOCR;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Camera'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      openDialog(context);
                    },
                    child: Text('Pick Image',
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ),
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Text(
                        "${visionTextOCR == null ? '' : visionTextOCR.text}"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: (imageFile != null)
                                ? FileImage(
                              imageFile,
                            )
                                : AssetImage('images/profile.jpg'))),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> openDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choice"),
            actions: <Widget>[
              FlatButton(
                child: Text("Gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var file =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
                  File croppedFile = await ImageCropper.cropImage(
                    sourcePath: file.path,
                  );
                  VisionText visionText = await textRecognition(croppedFile);
                  setState(() {
                    imageFile=file;
                    visionTextOCR=visionText;
                  });
                },
              ),
              FlatButton(
                child: Text("Camera"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var file = await ImagePicker.pickImage(source: ImageSource.camera , maxWidth: 400 , maxHeight: 400 ,);
                  File croppedFile = await ImageCropper.cropImage(sourcePath: file.path);
                  VisionText visionText = await textRecognition(croppedFile);
                  print(visionText.text);
                  setState(() {
                    imageFile=file;
                    visionTextOCR=visionText;
                  });

                },
              )
            ],
          );
        });
  }

  Future<VisionText> textRecognition(File imageFile) {
    final FirebaseVisionImage visionImage =
    FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer =
    FirebaseVision.instance.textRecognizer();
    final Future<VisionText> visionText =
    textRecognizer.processImage(visionImage);
    return visionText;
  }
}
