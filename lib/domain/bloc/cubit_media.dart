import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaCubit extends Cubit<MediaState> {
  MediaCubit() : super(MediaInitial());



}

@immutable
abstract class MediaState {}

class MediaInitial extends MediaState {}

class MediaError extends MediaState {
  final String error;

  MediaError(this.error);
}