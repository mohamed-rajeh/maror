import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maroor/components/shared/snackbar.dart';

Future<Uint8List> loadImageBytes(String imagePath) async {
  File imageFile = File(imagePath);
  Uint8List imageBytes = await imageFile.readAsBytes();
  return imageBytes;
}

Future<Uint8List?> getFileBytes(XFile image) async {
  try {
    final bytes = await File(image.path).readAsBytes();
    return bytes;
  } catch (e) {
    showSnackBar("Error reading image bytes: $e");
    return null;
  }
}

Future<Uint8List?> getAssetBytes(String assetPath) async {
  try {
    final byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  } catch (e) {
    showSnackBar('Error loading asset bytes: $e');
    return null;
  }
}
