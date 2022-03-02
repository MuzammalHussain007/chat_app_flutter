import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as systempath;

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePicFn);
  final void Function(File pickedImage) imagePicFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {


  File _pickedImage = File("");
  void _uploadImageFromGallery() async {
    final pickedImagefile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage =File(pickedImagefile!.path);
    });
    widget.imagePicFn(_pickedImage);

  }


  void _uploadImageFromCamera() async {
    final pickedImagefile = await  ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage =File(pickedImagefile!.path);
    });
    widget.imagePicFn(_pickedImage);
  }
  void _pickImage()
  {
   showModalBottomSheet(context: context, builder: (ctx){
     return Wrap(
       children:   [
         ListTile(
           leading: const Icon(Icons.camera),
           title: const Text('Camera'),
           onTap: (){
             _uploadImageFromCamera();
             Navigator.of(context).pop();
           },
         ),
          ListTile(
           leading: const Icon(Icons.browse_gallery),
           title: const Text('Gallery'),
           onTap: (){
             _uploadImageFromGallery();
             Navigator.of(context).pop();

           },
         ),
       ],
     );
   });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         CircleAvatar(radius: 40.0,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage !=null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(onPressed: (){
          _pickImage();
        },
            textColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.image),
            label: const Text('Add Image')),
      ],
    );
  }
}


