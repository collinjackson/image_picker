import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Image Picker Demo',
      home: new MyHomePage(title: 'Image Picker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription<ImageProvider> _subscription;
  MockImagePicker _imagePicker = new MockImagePicker();
  Image _image;
  int _counter = 0;

  @override
  void initState() {
    _subscription = _imagePicker.onImagePicked.listen((ImageProvider provider) {
      setState(() {
        _image = new Image(image: provider);
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
  }

  void _pickImage() {
    setState(() {
      _image = null;
      _counter++;
      _imagePicker.url = 'http://thecatapi.com/api/images/get?format=src&type=gif&count=$_counter';
    });
    _imagePicker.pickImage();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Image Picker Example'),
      ),
      body: new Center(
        child: _image ?? new Text('You have not yet picked an image.')
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
