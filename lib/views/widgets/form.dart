import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formapp/constants/regexpattern.dart';
import 'package:formapp/constroller/uploadimage.dart';
import 'package:formapp/model/userapi.dart';
import 'package:formapp/size.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'textinput.dart';
import 'package:uuid/uuid.dart';

class Formpart extends StatefulWidget {
  @override
  _FormpartState createState() => _FormpartState();
}

class _FormpartState extends State<Formpart> {
  bool _loading = false;

  Future _uploadFile(value, id) async {
    setState(() {
      _loading = true;
    });
    String imageurl = await Upload().uploadprofile(value, id);

    Map<String, dynamic> data = {
      "name": name.text,
      "number": mobilenumber.text,
      "image": imageurl,
    };
    var output = await Api().postdata(data);

    setState(() {
      name.text = "";
      _image = null;
      mobilenumber.text = "";
      _loading = false;
    });

    Fluttertoast.showToast(
        msg: output.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12);
  }

  final picker = ImagePicker();

  Future<Null> _imagecrop(value) async {
    File croppedFile = await ImageCropper.cropImage(
        maxHeight: 600,
        maxWidth: 600,
        sourcePath: value,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                // CropAspectRatioPreset.ratio4x3,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.orange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        _image = croppedFile;
      });
    }
  }

  Future image(value) async {
    final pickedFile =
        await picker.pickImage(source: value, maxHeight: 600, maxWidth: 600);
    if (pickedFile != null) {
      await _imagecrop(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  void _showstoragechoice(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.camera),
                  title: new Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    image(ImageSource.camera);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo),
                  title: new Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    image(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  File _image;
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : Container(
            height: double.infinity,
            width: double.infinity,
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Inputform("Name", "Enter your name", name, (value) {
                        if (value.isEmpty) {
                          return "* Required";
                        }
                      }),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 2, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Image"),
                            SizedBox(
                              height: SizeConfig.height * 2,
                            ),
                            InkWell(
                              onTap: () => _showstoragechoice(context),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                alignment: Alignment.center,
                                width: SizeConfig.width * 40,
                                height: SizeConfig.width * 40,
                                child: _image == null
                                    ? Icon(Icons.camera_alt)
                                    : Image.file(_image),
                              ),
                            )
                          ],
                        ),
                      ),
                      Inputform(
                          "Contact Number", "Enter your number", mobilenumber,
                          (value) {
                        if (value.isEmpty) {
                          return "* Required";
                        }
                        RegExp regex = new RegExp(numberpattern);
                        if (!regex.hasMatch(value)) {
                          return 'Please enter only number';
                        }

                        if (value.length > 10 || value.length < 10) {
                          return "Please enter only 10 numbers";
                        }
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text('Submit'),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                if (_image == null) {
                                  Fluttertoast.showToast(
                                      msg: "Please add your Image",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 12);
                                } else {
                                  print(_image);
                                  _uploadFile(_image, Uuid().v4());
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Not validate",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 12);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 12),
                                textStyle: TextStyle(fontSize: 15)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }
}
