import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:didit/client/client_account.dart';
import 'package:didit/util/processor_image.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit() : super(EditLoading()) {
    fetchData();
  }

  final AccountClient accountClient = AccountClient();
  XFile? image;
  String? name = '';
  String? bio = '';

  fetchData() async {
    try {
      final Map<String, dynamic> data = await accountClient.getProfile();
      name = data['name'];
      bio = data['bio'];
      emit(EditLoaded(data));
    } on String catch (error) {
      emit(EditError(error));
    }
  }

  void setName(String text) => name = text;

  void setBio(String text) => bio = text;

  void changePictureGallery() async {
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
      emit(EditPreview(image.path));
    } on PlatformException catch (error) {
      emit(EditFailure(error.toString()));
    } on Exception catch (error) {
      emit(EditFailure(error.toString()));
    }
  }

  void changePictureCamera() async {
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
      emit(EditPreview(image.path));
    } on PlatformException catch (error) {
      if (error.code == 'camera_access_denied') {
        emit(EditPermission());
      } else {
        emit(EditFailure(error.toString()));
      }
    } on Exception catch (error) {
      emit(EditFailure(error.toString()));
    }
  }

  void removePicture() async {
    image = XFile('');
    emit(EditPreview(image?.path));
  }

  void saveProfile() async {
    try {
      emit(EditSaving());
      final XFile? image = this.image;
      final String? name = this.name;
      final String? bio = this.bio;
      final File? file;
      if (image != null) {
        if (image.path.isEmpty) {
          file = File('');
        } else {
          file = await processImage(image);
        }
      } else {
        file = null;
      }
      await accountClient.saveProfile({
        'file': file,
        'name': name,
        'bio': bio,
      });
      await file?.delete();
      emit(EditFinished());
    } on String catch (error) {
      emit(EditFailure(error));
    }
  }
}

@immutable
abstract class EditState {}

class EditLoading extends EditState {}

class EditLoaded extends EditState {
  final Map<String, dynamic> data;

  EditLoaded(this.data);
}

class EditPreview extends EditState {
  final String? path;

  EditPreview(this.path);
}

class EditError extends EditState {
  final String error;

  EditError(this.error);
}



class EditPermission extends EditState {}


class EditSaving extends EditState {}

class EditFinished extends EditState {}

class EditFailure extends EditState {
  final String error;

  EditFailure(this.error);
}