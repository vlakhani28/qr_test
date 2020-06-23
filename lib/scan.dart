import 'package:flutter/material.dart';
import 'dart:async';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/services.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String barcode;

  Future scan() async{
    try{
      String barcode = await scanner.scan();
      setState(() {
        this.barcode = barcode;
        print(this.barcode);
      });
    }
    on PlatformException catch(e){
      if(e.code == scanner.CameraAccessDenied)
        setState(() {
          this.barcode = "Camera permission not granted";
        });
      else{
        setState(() {
          this.barcode = "Unknown error : $e";
        });
      }
    }
    catch(e)
    {
      setState(() {
        this.barcode = "Unknown error :$e";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: RaisedButton(
                color: Colors.purple,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: scan,
                child: Icon(Icons.camera,color: Colors.white,size: 24.0,)
            ),
          )
        ],
      ),),
    );
  }
}
