import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Upload {
  Future uploadprofile(value, id) async {
    print("image uploading");
    String downloadURL;
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('user/$id/profile.jpg')
          .putFile(value);
      downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('user/$id/profile.jpg')
          .getDownloadURL();
      print(downloadURL);
      // _submit(id, downloadURL);
    } catch (e) {
      print(e);
      // e.g, e.code == 'canceled'
    }
    return downloadURL;
  }
}
