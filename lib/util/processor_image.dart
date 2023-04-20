import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

Future<File> processImage(XFile image) async {
  final Uint8List bytes = await image.readAsBytes();
  final img.Image? decodedImage = img.decodeImage(bytes);
  if (decodedImage == null) throw 'Image Decoding Failed';
  const double desiredAspectRatio = 4 / 5;
  final double imageAspectRatio = decodedImage.width / decodedImage.height;
  final int croppedWidth = (imageAspectRatio >= desiredAspectRatio)
      ? (decodedImage.height * desiredAspectRatio).round()
      : decodedImage.width;
  final int croppedHeight = (imageAspectRatio >= desiredAspectRatio)
      ? decodedImage.height
      : (decodedImage.width / desiredAspectRatio).round();
  final int offsetX = ((decodedImage.width - croppedWidth) / 2).round();
  final int offsetY = ((decodedImage.height - croppedHeight) / 2).round();
  final img.Image croppedImage = img.copyCrop(
    decodedImage,
    x: offsetX,
    y: offsetY,
    width: croppedWidth,
    height: croppedHeight,
  );
  final Directory temporaryDirectory = await getTemporaryDirectory();
  final String path = '${temporaryDirectory.path}/image.jpg';
  final File file = File(path);
  await file.writeAsBytes(img.encodeJpg(croppedImage));
  return file;
}