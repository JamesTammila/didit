import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:didit/client/client_home.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/model/model_post.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit(this.postRepository) : super(MatchLoading()) {
    fetchMatch();
  }

  final PostRepository postRepository;
  final HomeClient homeClient = HomeClient();
  XFile? image;

  void fetchMatch() async {
    try {
      if (state is! MatchLoading) emit(MatchLoading());
      final PostModel match = await postRepository.getMatch();
      emit(MatchLoaded(match));
    } on String catch (error) {
      emit(MatchError(error));
    }
  }

  void takePostGallery() async {
    try {
      final XFile? image = await ImagePicker().pickImage(
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
      final XFile? image = await ImagePicker().pickImage(
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
      /*final XFile? image = this.image;
      if (image == null) return;
      final File file = File(image.path);
      final img.Image? decodedImage = img.decodeImage(file.readAsBytesSync());
      if (decodedImage == null) throw "Image Decoding Failed";
      final int croppedSize = min(decodedImage.width, decodedImage.height);
      final int offsetX = (decodedImage.width - min(decodedImage.width, decodedImage.height)) ~/ 2;
      final int offsetY = (decodedImage.height - min(decodedImage.width, decodedImage.height)) ~/ 2;
      final img.Image croppedImage = img.copyCrop(
        decodedImage,
        x: offsetX,
        y: offsetY,
        width: croppedSize,
        height: croppedSize,
      );
      final Directory temporaryDirectory = await getTemporaryDirectory();
      final String temporaryPath = temporaryDirectory.path;
      final File croppedFile = File('$temporaryPath/image.jpg');
      await croppedFile.writeAsBytes(img.encodeJpg(croppedImage));
      await homeClient.uploadPost(croppedFile);
      await file.delete();
      await croppedFile.delete();
      emit(MatchPictureUploaded());*/
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