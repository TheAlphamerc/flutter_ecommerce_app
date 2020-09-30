import 'dart:async';
import 'dart:io';
import 'package:Word/models/feel.dart';
import 'package:Word/services/firebase_storage_service.dart';
import 'package:Word/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class FeelBloc {
  final _feelings = BehaviorSubject<String>();
  final _feelTitle = BehaviorSubject<String>();
  final _feelImageUrl = BehaviorSubject<String>();
  final _userId = BehaviorSubject<String>();
  final _feelSaved = PublishSubject<bool>();
  final _feel = BehaviorSubject<Feel>();
  final _isLoading = BehaviorSubject<bool>();

  final db = FirestoreService();
  var uuid = Uuid();
  final _picker = ImagePicker();
  final storageService = FirebaseStorageService();

  //Get

  Stream<String> get feelings => _feelings.stream.transform(validateFeelings);
  Stream<String> get feelTitle =>
      _feelTitle.stream.transform(validateFeelTitle);
  Stream<String> get feelImageUrl => _feelImageUrl.stream;
  Stream<bool> get isValid =>
      CombineLatestStream.combine2(feelings, feelTitle, (a, b) => true);
  Stream<List<Feel>> feelByUserId(String userId) =>
      db.fetchFeelByUserId(userId);
  Stream<List<Feel>> fetchFeel() => db.fetchFeel();
  Stream<bool> get feelSaved => _feelSaved.stream;
  Stream<bool> get isLoading => _isLoading.stream;
  Future<Feel> fetchFeelByFeelId(String feelId) => db.fetchFeelByFeelId(feelId);

  //Set
  Function(String) get changeFeelings => _feelings.sink.add;
  Function(String) get changeFeelTitle => _feelTitle.sink.add;
  Function(String) get changeImageUrl => _feelImageUrl.sink.add;
  Function(String) get changeUserId => _userId.sink.add;
  Function(Feel) get changeFeel => _feel.sink.add;

  dispose() {
    _feelings.close();
    _feelTitle.close();
    _feelImageUrl.close();
    _userId.close();
    _feelSaved.close();
    _feel.close();
    _isLoading.close();
  }

  //Functions

  Future<void> saveFeel() async {
    var feel = Feel(
        feelings: _feelings.value.trim(),
        feelTitle: _feelTitle.value.trim(),
        feelDate: (_feel.value == null)
            ? DateTime.now().toIso8601String()
            : _feel.value.feelDate,
        feelId: (_feel.value == null) ? uuid.v4() : _feel.value.feelId,
        userId: _userId.value,
        feelImgUrl: _feelImageUrl.value);

    return db
        .setFeel(feel)
        .then((value) => _feelSaved.sink.add(true))
        .catchError((error) => _feelSaved.sink.add(false));
  }

  pickImage() async {
    PickedFile image;
    File cropped;

    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      //Get Image from the device
      image = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 75,
      );

      //Crop the image
      if (image != null) {
        cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Adjust Tweeks',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          compressQuality: 75, 
          compressFormat: ImageCompressFormat.jpg,
        );
      } else {
        print("No Path Received");
      }

      //Upload to Firebase
      if (cropped != null) {
        _isLoading.add(true);
        var feelImageUrl =
            await storageService.uploadFeelImage(File(cropped.path), uuid.v4());
        changeImageUrl(feelImageUrl);
        _isLoading.add(false);
      } else {
        print("No Path Received");
      }
    } else {
      print("Grant Permissions and try again");
    }
  }

  //Transformer
  final validateFeelings = StreamTransformer<String, String>.fromHandlers(
      handleData: (feelings, sink) {
    if (feelings != null) {
      if (feelings.length >= 20) {
        sink.add(feelings.trim());
      } else {
        sink.addError("Please write for atleast 20 Character");
      }
    }
  });
  final validateFeelTitle = StreamTransformer<String, String>.fromHandlers(
      handleData: (feelTitle, sink) {
    if (feelTitle != null) {
      if (feelTitle.length >= 3 && feelTitle.length <= 30) {
        sink.add(feelTitle.trim());
      } else {
        if (feelTitle.length < 30)
          sink.addError("Sorry! 3 Characters Minimum");
        else
          sink.addError("Sorry! 30 Characters Maximum");
      }
    }
  });
}
