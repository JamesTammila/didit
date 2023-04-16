import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/model/model_media.dart';
import 'package:didit/util/processor_image.dart';
import 'package:didit/util/mock_database.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit(this.postRepository) : super(MatchLoading());

  final PostRepository postRepository;
  PostModel? match;
  XFile? image;

  void init() async {
    try {
      match = mockMatch;
      /*final PostModel? match = await postRepository.getMatch();
      this.match = match;
      if (match == null) {
        emit(MatchEmpty());
      } else {
        final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
        if (user == null) throw 'User Null';
        final String? userId = user.objectId;
        if (userId == null) throw 'UserId Null';
        String url = '';
        for (MediaModel media in match.medias) {
          if (userId == media.user.objectId) {
            url = media.getUrl;
            break;
          }
        }
        if (url.isEmpty) {
          emit(MatchUnposted(match));
        } else {
          emit(MatchPosted({
            'url': url,
            'match': match,
          }));
        }
      }*/
      emit(MatchUnposted(match!));
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
      emit(MatchUnpostedPreview(image.path));
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
      emit(MatchUnpostedPreview(image.path));
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

  void uploadPost() async {
    try {
      final PostModel? match = this.match;
      final XFile? image = this.image;
      if (match == null || image == null) return;
      emit(MatchUnpostedUploading());
      final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
      if (user == null) throw 'User Null';
      final String? userId = user.objectId;
      if (userId == null) throw 'UserId Null';
      String? mediaId;
      for (MediaModel media in match.medias) {
        if (userId == media.user.objectId) {
          mediaId = media.objectId;
          if (media.getUrl.isNotEmpty) throw 'You have already posted.';
          break;
        }
      }
      if (mediaId == null) throw 'MediaId Null';

      final File file = await processImage(image);
      await postRepository.uploadPost(mediaId, file);
      await file.delete();
      emit(MatchUnpostedUploaded());
    } on String catch (error) {
      emit(MatchUploadFailure(error));
    }
  }
}

@immutable
abstract class MatchState {}

class MatchPermission extends MatchState {}

class MatchLoading extends MatchState {}

class MatchEmpty extends MatchState {}

class MatchUnposted extends MatchState {
  final PostModel match;

  MatchUnposted(this.match);
}

class MatchPosted extends MatchState {
  final Map<String, dynamic> data;

  MatchPosted(this.data);
}

class MatchError extends MatchState {
  final String error;

  MatchError(this.error);
}

class MatchUnpostedPreview extends MatchState {
  final String path;

  MatchUnpostedPreview(this.path);
}

class MatchUnpostedUploading extends MatchState {}

class MatchUnpostedUploaded extends MatchState {}

class MatchFailure extends MatchState {
  final String error;

  MatchFailure(this.error);
}

class MatchUploadFailure extends MatchState {
  final String error;

  MatchUploadFailure(this.error);
}