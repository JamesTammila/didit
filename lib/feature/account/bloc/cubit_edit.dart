import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:didit/client/client_account.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/mock_database.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit() : super(EditLoading()) {
    fetchData();
  }

  final AccountClient accountClient = AccountClient();
  XFile? image;
  String? name;
  String? bio;

  fetchData() {
    const UserModel userModel = mockMe;
    emit(EditLoaded(userModel));
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
    image = null;
    emit(EditRemoved());
  }

  void saveProfile() async {
    try {
      emit(EditSaving());
      /*final XFile? image = this.image;
      final String? name = this.name;
      final String? bio = this.bio;
      if (image == null) return; // Handle ProPic Deletion
      final Directory temporaryDirectory = await getTemporaryDirectory();
      final String temporaryPath = temporaryDirectory.path;
      final File file = File(image.path);
      final File fileCopy = await file.copy('$temporaryPath/image.jpg');
      await accountClient.saveProfile({
        'file': fileCopy,
        'name': name,
        'bio': bio,
      });
      await file.delete();
      await fileCopy.delete();
      emit(EditFinished());*/
    } on String catch (error) {
      emit(EditFailure(error));
    }
  }
}

@immutable
abstract class EditState {}

class EditLoading extends EditState {}

class EditLoaded extends EditState {
  final UserModel userModel;

  EditLoaded(this.userModel);
}

class EditPreview extends EditState {
  final String path;

  EditPreview(this.path);
}

class EditRemoved extends EditState {}

class EditError extends EditState {
  final String error;

  EditError(this.error);
}

class EditSaving extends EditState {}

class EditFinished extends EditState {}

class EditPermission extends EditState {}

class EditFailure extends EditState {
  final String error;

  EditFailure(this.error);
}