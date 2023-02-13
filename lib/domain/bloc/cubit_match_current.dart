import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:didit/data/client/client_database.dart';
import 'package:didit/domain/model/model_match.dart';
import 'package:didit/mock_database.dart';

class CurrentMatchCubit extends Cubit<CurrentMatchState> {
  CurrentMatchCubit() : super(CurrentMatchLoading()) {
    fetchCurrentMatch();
  }

  final DatabaseClient databaseClient = DatabaseClient();

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

  void uploadPost(String source) async {
    try {
      final ImageSource imageSource;
      if (source == 'gallery') {
        imageSource = ImageSource.gallery;
      } else {
        imageSource = ImageSource.camera;
      }
      final image = await ImagePicker().pickImage(
        requestFullMetadata: false,
        source: imageSource,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 80,
      );
      if (image == null) return;
      /*Directory temporaryDirectory = await getTemporaryDirectory();
      String temporaryPath = temporaryDirectory.path;
      File file = File(image.path);
      File fileCopy = await file.copy('$temporaryPath/image.jpg');
      await databaseClient.uploadPost(fileCopy);
      await file.delete();
      await fileCopy.delete();*/
    } on PlatformException catch (error) {
      emit(CurrentMatchFailure(error.toString()));
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

class CurrentMatchFailure extends CurrentMatchState {
  final String error;

  CurrentMatchFailure(this.error);
}