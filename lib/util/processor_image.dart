import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

Future<File> processImage(XFile image) async {
  final File file = File(image.path);
  final img.Image? decodedImage = img.decodeImage(file.readAsBytesSync());
  if (decodedImage == null) throw 'Image Decoding Failed';
  final int croppedSize = min(decodedImage.width, decodedImage.height);
  final int offsetX = (decodedImage.width - min(decodedImage.width, decodedImage.height)) ~/ 2;
  final int offsetY = (decodedImage.height - min(decodedImage.width, decodedImage.height)) ~/ 2;
  final img.Image croppedImage = img.copyCrop(
    decodedImage,
    x: offsetX,
    y: offsetY,
    width: croppedSize,
    height: croppedSize,
  );
  final Directory temporaryDirectory = await getTemporaryDirectory();
  final String temporaryPath = temporaryDirectory.path;
  final File croppedFile = File('$temporaryPath/image.jpg');
  await croppedFile.writeAsBytes(img.encodeJpg(croppedImage));
  await file.delete();
  return croppedFile;
}