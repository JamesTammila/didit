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

class PostCubit extends Cubit<PostState> {
  PostCubit(this.postRepository) : super(PostLoading());

  final PostRepository postRepository;
  PostModel? match;
  XFile? image;

  void init() async {
    try {
      final PostModel? match = await postRepository.getMatch();
      this.match = match;
      /*if (match != null) {
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
          emit(PostEmpty(match));
        } else {
          emit(PostLoaded({
            'url': url,
            'match': match,
          }));
        }
      }*/
      emit(PostLoaded({
        'url': 'https://img.delicious.com.au/WqbvXLhs/del/2016/06/more-the-merrier-31380-2.jpg',
        'match': match,
      }));
      //emit(PostEmpty(match!));
    } on String catch (error) {
      emit(PostError(error));
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
      emit(PostPreview(image.path));
    } on PlatformException catch (error) {
      emit(PostFailure(error.toString()));
    } on String catch (error) {
      emit(PostFailure(error));
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
      emit(PostPreview(image.path));
    } on PlatformException catch (error) {
      if (error.code == 'camera_access_denied') {
        emit(PostPermission());
      } else {
        emit(PostFailure(error.toString()));
      }
      emit(PostFailure(error.toString()));
    } on String catch (error) {
      emit(PostFailure(error));
    }
  }

  void uploadPost() async {
    try {
      final PostModel? match = this.match;
      final XFile? image = this.image;
      if (match == null || image == null) return;
      emit(PostUploading());
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
      emit(PostUploaded());
    } on String catch (error) {
      emit(PostUploadFailure(error));
    }
  }
}

@immutable
abstract class PostState {}

class PostPermission extends PostState {}

class PostLoading extends PostState {}

class PostEmpty extends PostState {
  final PostModel match;

  PostEmpty(this.match);
}

class PostLoaded extends PostState {
  final Map<String, dynamic> data;

  PostLoaded(this.data);
}

class PostError extends PostState {
  final String error;

  PostError(this.error);
}

class PostPreview extends PostState {
  final String path;

  PostPreview(this.path);
}

class PostUploading extends PostState {}

class PostUploaded extends PostState {}

class PostFailure extends PostState {
  final String error;

  PostFailure(this.error);
}

class PostUploadFailure extends PostState {
  final String error;

  PostUploadFailure(this.error);
}