import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlatformCubit extends Cubit<PlatformState> {
  PlatformCubit() : super(PlatformLoading());

  void init() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      emit(PlatformIOS());
    } else {
      emit(PlatformAndroid());
    }
  }
}

@immutable
abstract class PlatformState {}

class PlatformLoading extends PlatformState {}

class PlatformIOS extends PlatformState {}

class PlatformAndroid extends PlatformState {}