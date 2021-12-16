import 'dart:typed_data';

import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class VerificationUploadAlert extends StatefulWidget {
  const VerificationUploadAlert({Key key, this.onImagePicked, this.skipImage})
      : super(key: key);
  final Function onImagePicked;
  final Function skipImage;

  @override
  _VerificationUploadAlertState createState() =>
      _VerificationUploadAlertState();
}

class _VerificationUploadAlertState extends State<VerificationUploadAlert> {
  final ImagePicker _picker = ImagePicker();

  XFile _imageData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 0),
      actionsPadding: EdgeInsets.all(5),
      title: Text('Please upload verification Image'),
      clipBehavior: Clip.antiAlias,
      content: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ListTile(
          //   onTap: () {

          //   },
          //   leading: Icon(
          //     Icons.camera_alt,
          //     color: MainTheme.primaryColor,
          //     size: 30,
          //   ),
          //   title: Text(
          //     'Take a Photo',
          //     style: TextStyle(fontSize: 15, color: Colors.black),
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     _displayImagePicker(ImageSource.gallery);
          //   },
          //   leading: Icon(
          //     Icons.image,
          //     size: 30,
          //     color: MainTheme.primaryColor,
          //   ),
          //   title: Text(
          //     'Choose From Library',
          //     style: TextStyle(fontSize: 15, color: Colors.black),
          //   ),
          // ),
        ],
      )),
      actions: [
        SizedBox(
          height: 30,
          child: TextButton(
              onPressed: () {
                widget.skipImage();
              },
              child: Text('Skip',
                  style:
                      TextStyle(color: MainTheme.primaryColor, fontSize: 13))),
        ),
        SizedBox(
          height: 30,
          child: TextButton(
              onPressed: () {
                _displayImagePicker(ImageSource.camera);
              },
              child: Text('Continue',
                  style:
                      TextStyle(color: MainTheme.primaryColor, fontSize: 13))),
        ),
      ],
    );
  }

  void _displayImagePicker(ImageSource source) async {
    if (!kIsWeb) {
      var pickedFile;
      // Map<Permission, PermissionStatus> statuses = await [
      //   Permission.storage,
      //   Permission.camera,
      // ].request();

      try {
        Navigator.of(context).pop();
        if (source == ImageSource.camera) {
          if (await Permission.camera.request().isGranted) {
            pickedFile = await _picker.pickImage(
              source: ImageSource.camera,
              // imageQuality: 10,
              // preferredCameraDevice: CameraDevice.rear
            );
            _imageData = pickedFile;
          } else {
            openAppSettings();
          }
        } else {
          if (await Permission.storage.request().isGranted) {
            final pickedFile = await _picker.pickImage(
              source: ImageSource.gallery,
              imageQuality: 10,
            );

            print("dasds");
            _imageData = pickedFile;
          } else {
            openAppSettings();
          }
        }
        widget.onImagePicked(_imageData);
      } catch (e) {
        print(e.toString());
        showtoast(source.toString());
      }
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
      );
      print("image convert aakuthaa");
      Uint8List uploadfile = result.files.first.bytes;
      widget.onImagePicked(uploadfile);
    }
  }
}
