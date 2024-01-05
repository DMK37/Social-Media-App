import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/components/edit_profile_text.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  File? _image;
  final picker = ImagePicker();

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) {
      return null;
    } else {
      return File(croppedImage.path);
    }
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        context.pop();
      });
    } on PlatformException catch (e) {
      print(e);
      context.pop();
    }
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              _pickImage(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              _pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  iconSize: 50,
                  onPressed: () {},
                  icon: const Icon(Icons.photo_library)),
              IconButton(
                  iconSize: 50,
                  onPressed: () {},
                  icon: const Icon(Icons.video_library))
            ],
          ),
          TextButton(
            child: Text('Select Image'),
            onPressed: showOptions,
          ),
          Center(
            child: _image == null
                ? Text('No Image selected')
                : Image.file(_image!),
          ),
          const SizedBox(height: 30),
          Expanded(
//makes textfield scrollable - wrap in Expanded widget + maxlines = null
            child: TextField(
              maxLines: null, //wrap text
              autofocus: true,
              autocorrect: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              controller: descriptionController,
            ),
          )
        ],
      ),
    );
  }
}
