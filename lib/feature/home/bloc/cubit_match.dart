import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:image_picker/image_picker.dart';
import 'package:didit/client/client_post.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/model/model_media.dart';
import 'package:didit/util/processor_image.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit(this.postRepository) : super(MatchLoading()) {
    fetchMatch();
  }

  final PostClient postClient = PostClient();
  final PostRepository postRepository;
  XFile? image;
  PostModel? match;

  void fetchMatch() async {
    try {
      if (state is! MatchLoading) emit(MatchLoading());
      final PostModel? match = await postRepository.getMatch();
      this.match = match;
      if (match == null) {
        emit(MatchEmpty());
      } else {
        emit(MatchLoaded(match));
      }
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
      final PostModel? match = this.match;
      final XFile? image = this.image;
      if (match == null || image == null) return;

      final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
      if (user == null) throw 'User Null';
      final String? userId = user.objectId;
      if (userId == null) throw 'UserId Null';
      String? mediaId;
      for (MediaModel media in match.medias) {
        if (userId == media.user.objectId) {
          mediaId = media.objectId;
          break;
        }
      }
      if (mediaId == null) throw 'MediaId Null';

      final File file = await processImage(image);
      await postClient.uploadPost(mediaId, file);
      await file.delete();
      emit(MatchPictureUploaded());
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