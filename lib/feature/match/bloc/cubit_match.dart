import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:image_picker/image_picker.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/model/model_match.dart';
import 'package:didit/model/model_media.dart';
import 'package:didit/util/processor_image.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit(this.postRepository) : super(MatchLoading());

  final PostRepository postRepository;
  MatchModel? match;
  XFile? image;

  void init() async {
    try {
      final MatchModel? match = await postRepository.getMatch();
      this.match = match;
      if (match == null) {
        emit(MatchEmpty());
      } else {
        if (match.isFinished) {
          emit(MatchFinished(match));
        } else {
          /*final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
          if (user == null) throw 'User Null';
          final String? userId = user.objectId;
          if (userId == null) throw 'UserId Null';
          String? url;
          for (MediaModel media in match.medias) {
            if (userId == media.user.objectId) {
              url = media.getUrl;
              break;
            }
          }*/
          String url = '';
          if (url.isEmpty) {
            emit(MatchUnfinished(match));
          } else {
            emit(MatchPartial({
              'url': url,
              'match': match,
            }));
          }
        }
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
      emit(MatchUnfinishedPreview(image.path));
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
      emit(MatchUnfinishedPreview(image.path));
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
    emit(MatchUnfinishedEmpty());
  }

  void uploadPost() async {
    try {
      emit(MatchUnfinishedUploading());
      /*final MatchModel? match = this.match;
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
          if (media.getUrl.isNotEmpty) throw 'You have already posted.';
          break;
        }
      }
      if (mediaId == null) throw 'MediaId Null';

      final File file = await processImage(image);
      await postRepository.uploadPost(mediaId, file);
      await file.delete();*/
      await Future.delayed(const Duration(milliseconds: 500));

      emit(MatchUnfinishedUploaded());
    } on String catch (error) {
      emit(MatchFailure(error));
    }
  }

  void deletePost() async {
    try {
      emit(MatchFinishedDeleting());
      /*final MatchModel? match = this.match;
      if (match == null) return;
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
      await postRepository.deletePost(mediaId);*/
      await Future.delayed(const Duration(milliseconds: 500));
      emit(MatchFinishedDeleted());
    } on String catch (error) {
      emit(MatchFailure(error));
    }
  }
}

@immutable
abstract class MatchState {}

class MatchPermission extends MatchState {}

class MatchLoading extends MatchState {}

class MatchEmpty extends MatchState {}

class MatchFinished extends MatchState {
  final MatchModel match;

  MatchFinished(this.match);
}

class MatchPartial extends MatchState {
  final Map<String, dynamic> data;

  MatchPartial(this.data);
}

class MatchUnfinished extends MatchState {
  final MatchModel matchModel;

  MatchUnfinished(this.matchModel);
}

class MatchError extends MatchState {
  final String error;

  MatchError(this.error);
}

class MatchUnfinishedEmpty extends MatchState {}

class MatchUnfinishedPreview extends MatchState {
  final String path;

  MatchUnfinishedPreview(this.path);
}

class MatchUnfinishedUploading extends MatchState {}

class MatchUnfinishedUploaded extends MatchState {}

class MatchFinishedDeleting extends MatchState {}

class MatchFinishedDeleted extends MatchState {}

class MatchFailure extends MatchState {
  final String error;

  MatchFailure(this.error);
}