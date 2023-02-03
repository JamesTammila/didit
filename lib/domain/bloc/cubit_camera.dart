import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInitial());



}

@immutable
abstract class CameraState {}

class CameraInitial extends CameraState {}

class CameraError extends CameraState {
  final String error;

  CameraError(this.error);
}