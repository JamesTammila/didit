import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:didit/data/client/client_database.dart';
import 'package:didit/domain/model/model_match.dart';
import 'package:didit/mock_database.dart';

class CurrentMatchCubit extends Cubit<CurrentMatchState> {
  CurrentMatchCubit() : super(CurrentMatchLoading()) {
    fetchCurrentMatch();
  }

  final DatabaseClient databaseClient = DatabaseClient();
  XFile? image;

  void fetchCurrentMatch() async {
    try {
      /*if (state is! CurrentMatchLoading) emit(CurrentMatchLoading());
      final data = await databaseClient.fetchMatch();
      final List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      final Map<String, dynamic> jsonObject = json.decode(results[0]["result"]);
      final currentMatch = MatchModel.fromJson(jsonObject);*/

      await Future.delayed(const Duration(seconds: 1));
      const currentMatch = mockCurrentMatch;

      emit(CurrentMatchLoaded(currentMatch));
    } on String catch (error) {
      emit(CurrentMatchError(error));
    }
  }

  void takePostGallery() async {
    try {
      final image = await ImagePicker().pickImage(
        requestFullMetadata: false,
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 80,
      );
      if (image == null) return;
      this.image = image;
      //Preview
    } on PlatformException catch (error) {
      emit(CurrentMatchFailure(error.toString()));
    } on String catch (error) {
      emit(CurrentMatchFailure(error));
    }
  }

  void takePostCamera() async {
    try {
      final image = await ImagePicker().pickImage(
        requestFullMetadata: false,
        source: ImageSource.camera,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 80,
      );
      if (image == null) return;
      this.image = image;
      //Preview
    } on PlatformException catch (error) {
      if (error.code == 'camera_access_denied') {
        emit(CurrentMatchPermission());
      } else {
        emit(CurrentMatchFailure(error.toString()));
      }
      emit(CurrentMatchFailure(error.toString()));
    } on String catch (error) {
      emit(CurrentMatchFailure(error));
    }
  }

  void removePost() async {
    //image = null;
    //emit(EditRemoved());
  }

  void uploadPost() async {
    try {
      emit(CurrentMatchUploading());
      final image = this.image;
      if (image == null) return; // Handle ProPic Deletion
      Directory temporaryDirectory = await getTemporaryDirectory();
      String temporaryPath = temporaryDirectory.path;
      File file = File(image.path);
      File fileCopy = await file.copy('$temporaryPath/image.jpg');
      await databaseClient.uploadPost(fileCopy);
      await file.delete();
      await fileCopy.delete();
      emit(CurrentMatchUploaded());
    } on String catch (error) {
      emit(CurrentMatchFailure(error));
    }
  }

  void openSettings() async {
    try {
      if (!await openAppSettings()) throw "Could not open app settings";
    } on String catch (error) {
      emit(CurrentMatchFailure(error));
    }
  }
}

@immutable
abstract class CurrentMatchState {}

class CurrentMatchLoading extends CurrentMatchState {}

class CurrentMatchLoaded extends CurrentMatchState {
  final MatchModel currentMatch;

  CurrentMatchLoaded(this.currentMatch);
}

class CurrentMatchEmpty extends CurrentMatchState {}

class CurrentMatchUploading extends CurrentMatchState {}

class CurrentMatchUploaded extends CurrentMatchState {}

class CurrentMatchError extends CurrentMatchState {
  final String error;

  CurrentMatchError(this.error);
}

class CurrentMatchPermission extends CurrentMatchState {}

class CurrentMatchFailure extends CurrentMatchState {
  final String error;

  CurrentMatchFailure(this.error);
}