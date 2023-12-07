import 'dart:io';

import 'package:cuidame/app/data/services/user_login_service.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class FirebaseStorageRepository {
  Future<String?> uploadCaregiverProfilePhoto(XFile file);
  Future<String?> uploadPatientProfilePhoto(XFile file);
}

class FirebaseStorageRepositoryImpl implements FirebaseStorageRepository {
  final storageRef = FirebaseStorage.instance.ref();
  final UserLoginService _userLoginService;

  FirebaseStorageRepositoryImpl(this._userLoginService);

  Future<String?> _uploadImage(XFile file, String path) async {
    final pathRef = storageRef.child(path);
    try {
      var upload = await pathRef.putFile(File(file.path));
      if (upload.state == TaskState.success) {
        return await pathRef.getDownloadURL();
      }
      return null;
    } on FirebaseException catch (e) {
      UtilsLogger().e(e);
      throw Exception();
    }
  }

  @override
  Future<String?> uploadCaregiverProfilePhoto(XFile file) async {
    final extension = file.name.split('.')[1];
    var path = '${_userLoginService.userUid}/profilePhoto/profile_photo.$extension';
    final url = await _uploadImage(file, path);
    return url;
  }

  @override
  Future<String?> uploadPatientProfilePhoto(XFile file) async {
    final extension = file.name.split('.')[1];
    var path = '${_userLoginService.userUid}/patient/profile_photo.$extension';
    final url = await _uploadImage(file, path);
    return url;
  }
}
