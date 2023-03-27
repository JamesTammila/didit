import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

Future<File> processImage(XFile image) async {
  final Uint8List bytes = await image.readAsBytes();
  final img.Image? decodedImage = img.decodeImage(bytes);
  if (decodedImage == null) throw 'Image Decoding Failed';
  final int croppedSize = min(decodedImage.width, decodedImage.height);
  final int offsetX = (decodedImage.width - croppedSize) ~/ 2;
  final int offsetY = (decodedImage.height - croppedSize) ~/ 2;
  final img.Image croppedImage = img.copyCrop(
    decodedImage,
    x: offsetX,
    y: offsetY,
    width: croppedSize,
    height: croppedSize,
  );
  final Directory temporaryDirectory = await getTemporaryDirectory();
  final String path = '${temporaryDirectory.path}/image.jpg';
  final File file = File(path);
  await file.writeAsBytes(img.encodeJpg(croppedImage));
  return file;
}