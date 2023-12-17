import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _output = [];
  bool loading = false;

  Future<String?> _askUserForEye() async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Eye'),
          content: const Text('Which eye did you take a picture of?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Left'),
              onPressed: () => Navigator.of(context).pop('left'),
            ),
            TextButton(
              child: const Text('Right'),
              onPressed: () => Navigator.of(context).pop('right'),
            ),
          ],
        );
      },
    );
  }

  Future<void> evaluateImage() async {
    if (_croppedFile == null) {
      // Show an error message or handle accordingly
      return;
    }
    // Ask the user for the eye information
    String? eye = await _askUserForEye();
    if (eye == null) {
      // User did not select an eye, handle accordingly
      return;
    }
    var user = FirebaseAuth.instance.currentUser;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.18.14:8000/check_for_cataract'),
    );
    // Add user identifier
    request.fields['email'] = user?.email ?? '';
    request.fields['eye'] = eye;
    // Attach the cropped image to the request
    request.files.add(
      await http.MultipartFile.fromPath('image', _croppedFile!.path),
    );
    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        // Successfully received response
        var responseData = await response.stream.bytesToString();
        var decodedResponse = json.decode(responseData);
        // Update the UI based on the server response
        if (decodedResponse.containsKey('result')) {
          bool result = decodedResponse['result'];
          // Now, you can update your UI based on the 'result'
          print('Server result: $result');
          // Example: Show a dialog with the result
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Result'),
                content:
                    Text(result ? 'Cataract Detected' : 'No Cataract Detected'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          print('Error: Result key not found in the server response');
        }
      } else {
        // Handle errors
        print('Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  bool isCropped = false;
  File? _image = null;
  CroppedFile? _croppedFile;

  final picker = ImagePicker();

  Future<void> _cropImage() async {
    if (_image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          isCropped = true;
          _croppedFile = croppedFile;
        });
      }
    }
  }

  void getGallery() async {
    final pickergallery = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickergallery != null) {
        _image = File(pickergallery.path);
      } else {
        print("no Image us inserted");
      }
    });
  }

  Future getImage() async {
    final pickerImage = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1200,
        imageQuality: 80);
    setState(() {
      if (pickerImage != null) {
        _image = File(pickerImage.path);
      } else {
        print("No Image is inserted");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            backgroundColor: Color(0xFF61A6FF),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF61A6FF),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  height: 350,
                  width: double.infinity,
                  child: _image == null
                      ? Center(
                          child: Text(
                          "Insert Your Eye Image here must crop your Eye image",
                          style: TextStyle(color: Colors.white),
                        ))
                      : isCropped == true
                          ? Image.file(File(_croppedFile!.path))
                          : Image.file(_image!),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {
                        getGallery();
                      },
                      child:
                          Icon(Icons.insert_drive_file, color: Colors.white)),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "---------Upload your photo-------------",
                  style: TextStyle(color: Colors.black.withOpacity(0.4)),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {
                        _cropImage();
                      },
                      child: Icon(Icons.crop, color: Colors.white)),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "---------Crop your image-------------",
                  style: TextStyle(color: Colors.black.withOpacity(0.4)),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {
                        getImage();
                      },
                      child: Icon(Icons.camera_alt_sharp, color: Colors.white)),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "---------Take your photo-------------",
                  style: TextStyle(color: Colors.black.withOpacity(0.4)),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        evaluateImage();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    10,
                                  ),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)))),
                      child: Text(
                        "Get Result",
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
