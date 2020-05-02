import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class QRScan extends StatefulWidget {
  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  String result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Scan"),
      ),
      body: Center(
        child: Text(
          result != null ? result : 'Scan QR',
          style: TextStyle(fontSize: 22),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: scanQR, label: Text("QR Scan"), icon: Icon(Icons.scanner)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future scanQR() async {
    try {
      String scanResult = await BarcodeScanner.scan();
      setState(() {
        result = scanResult;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown error";
        });
      }
    } on FormatException catch(e) {
      result = "You pressed the back button before scanning";
    } catch (e) {
      setState(() {
        result = "Other Error";
      });
    }
  }
}
