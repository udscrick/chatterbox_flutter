import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  ImagePickerWidget(this.imagePickFn);
final void Function(File pickedImage) imagePickFn;
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}
 
class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  void pickImage()async{
    var img = await ImagePicker().getImage(source: ImageSource.camera,imageQuality: 50,maxWidth: 150);
    setState(() {
          
          _imageFile = img;
        });

        widget.imagePickFn(File(_imageFile.path));
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          CircleAvatar(radius: 50,backgroundImage: _imageFile!=null?FileImage(File(_imageFile.path)):null),
          FlatButton.icon(onPressed: pickImage,
           icon: Icon(Icons.image)
          , label: Text('Add Image'),
          textColor: Theme.of(context).primaryColor,
          ),

      ],
    );
  }
}