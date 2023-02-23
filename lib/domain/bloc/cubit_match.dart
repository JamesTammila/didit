import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:didit/data/client/client_database.dart';
import 'package:didit/domain/model/model_post.dart';
import 'package:didit/mock_database.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit() : super(MatchLoading()) {
    fetchMatch();
  }

  final DatabaseClient databaseClient = DatabaseClient();
  XFile? image;

  void fetchMatch() async {
    try {
      /*if (state is! MatchLoading) emit(MatchLoading());
      final data = await databaseClient.fetchMatch();
      final List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      final Map<String, dynamic> jsonObject = json.decode(results[0]["result"]);
      final match = PostModel.fromJson(jsonObject);*/

      await Future.delayed(const Duration(seconds: 1));
      const match = mockMatch;

      emit(MatchLoaded(match));
    } on String catch (error) {
      emit(MatchError(error));
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
      emit(MatchPicturePreview(image.path));
    } on PlatformException catch (error) {
      emit(MatchFailure(error.toString()));
    } on String catch (error) {
      emit(MatchFailure(error));
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
      emit(MatchPicturePreview(image.path));
    } on PlatformException catch (error) {
      if (error.code == 'camera_access_denied') {
        emit(MatchPermission());
      } else {
        emit(MatchFailure(error.toString()));
      }
      emit(MatchFailure(error.toString()));
    } on String catch (error) {
      emit(MatchFailure(error));
    }
  }

  void removePost() async {
    image = null;
    emit(MatchPictureEmpty());
  }

  void uploadPost() async {
    try {
      emit(MatchPictureUploading());
      /*final image = this.image;
      if (image == null) return;
      final file = File(image.path);
      final decodedImage = img.decodeImage(file.readAsBytesSync());
      if (decodedImage == null) throw "Image Decoding Failed";
      final croppedSize = min(decodedImage.width, decodedImage.height);
      final offsetX = (decodedImage.width - min(decodedImage.width, decodedImage.height)) ~/ 2;
      final offsetY = (decodedImage.height - min(decodedImage.width, decodedImage.height)) ~/ 2;
      final croppedImage = img.copyCrop(
        decodedImage,
        x: offsetX,
        y: offsetY,
        width: croppedSize,
        height: croppedSize,
      );
      Directory temporaryDirectory = await getTemporaryDirectory();
      String temporaryPath = temporaryDirectory.path;
      File croppedFile = File('$temporaryPath/image.jpg');
      await croppedFile.writeAsBytes(img.encodeJpg(croppedImage));
      await databaseClient.uploadPost(croppedFile);
      await file.delete();
      await croppedFile.delete();
      emit(CurrentMatchPictureUploaded());*/
    } on String catch (error) {
      emit(MatchFailure(error));
    }
  }
}

@immutable
abstract class MatchState {}

class MatchLoading extends MatchState {}

class MatchLoaded extends MatchState {
  final PostModel match;

  MatchLoaded(this.match);
}

class MatchEmpty extends MatchState {}

class MatchError extends MatchState {
  final String error;

  MatchError(this.error);
}

class MatchPermission extends MatchState {}

class MatchPictureEmpty extends MatchState {}

class MatchPicturePreview extends MatchState {
  final String path;

  MatchPicturePreview(this.path);
}

class MatchPictureError extends MatchState {
  final String error;

  MatchPictureError(this.error);
}

class MatchPictureUploading extends MatchState {}

class MatchPictureUploaded extends MatchState {}

class MatchSaving extends MatchState {}

class MatchFailure extends MatchState {
  final String error;

  MatchFailure(this.error);
}