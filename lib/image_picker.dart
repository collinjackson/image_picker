import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class ImagePicker {
  static const PlatformMethodChannel _channel =
      const PlatformMethodChannel('image_picker');

  // Returns the URL of the picked image
  static Future<File> pickImage() async {
    String path = await _channel.invokeMethod('pickImage');
    return new File(path);
  }
}
