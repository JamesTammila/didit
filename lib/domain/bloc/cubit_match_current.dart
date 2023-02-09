import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
    final XFile? image;
    if (source == 'gallery') {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    }
    if (image == null) return;

    final size = await image.length();

    debugPrint('Image Picker: $size');

    /*File imageFile = File(image.path);

    Directory temporaryDirectory = await getTemporaryDirectory();
    String temporaryPath = temporaryDirectory.path;

    final result = await FlutterImageCompress.compressAndGetFile(
      image.path,
      '$temporaryPath/image.jpg',
      quality: 100,
    );

    await imageFile.delete();
    ParseFile imageParseFile = ParseFile(result);
    await result?.delete();
    await imageParseFile.save();*/
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

class CurrentMatchFailure extends CurrentMatchState {}