import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/post/create_post/cubit/create_post_state.dart';
import 'package:social_media/data/models/post_model.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/data/repository/post_repository.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  PostRepository postRepository = PostRepository();
  final _storage = FirebaseStorage.instance;
  final AuthCubit authCubit;
  File? imageFile;
  XFile? originalImage;
  List<String> tags = [
    "Portraits",
    "Landscapes",
    "StreetStyle",
    "Macro",
    "Monochrome",
    "Nature",
    "Travel",
    "Nighttime",
    "Fashion",
    "Abstract",
    "Film",
    "Wildlife",
    "Urban",
    "Events",
    "Aerial",
    "Underwater",
    "Tips",
    "Gear",
    "Inspiration",
    "Editing",
  ];

  List<String>? selectedTags = [];
  final picker = ImagePicker();
  CreatePostCubit({required this.authCubit}) : super(CreatePostInitiaState());

  Future<void> pickPostImage(ImageSource source) async {
    emit(CreatePostLoadingState());

    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 80,
    );
    originalImage = pickedFile;
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    emit(CreatePostInitiaState());
  }

  Future<void> croppPostImage() async {
    emit(CreatePostLoadingState());
    if (originalImage != null) {
      final croppedImage = await ImageCropper().cropImage(
        sourcePath: originalImage!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: const Color.fromRGBO(0, 125, 66, 0.7),
            //backgroundColor: Color.fromRGBO(0, 125, 66, 0.7),
            activeControlsWidgetColor: const Color.fromRGBO(0, 125, 66, 0.7),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
          ),
          IOSUiSettings(
            title: 'Cropper',
            //aspectRatioLockEnabled: true,
          ),
        ],
      );
      if (croppedImage != null) {
        imageFile = File(croppedImage.path);
      }
    }
    emit(CreatePostInitiaState());
  }

  createPost(String description) async {
    emit(CreatePostLoadingState());

    UserModel? user = (authCubit.state as AuthenticatedState).user;
    PostModel postModel = PostModel(
      userId: user.userId!,
      description: description,
      imageUrl: '',
      comments: [],
      tags: selectedTags ?? [],
      timestamp: DateTime.now(),
    );
    postModel = await postRepository.createPost(postModel);
    final ref = _storage.ref().child('post_images/${postModel.postId}.jpg');
    await ref.putFile(imageFile!);
    final url = await ref.getDownloadURL();
    String id = postModel.postId!;
    postModel = PostModel(
      userId: user.userId!,
      description: postModel.description,
      imageUrl: url,
      comments: postModel.comments,
      tags: postModel.tags,
      timestamp: postModel.timestamp,
    );
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .update(postModel.toJson());
    imageFile = null;
    originalImage = null;
    selectedTags = [];
    emit(CreatePostSuccessState());
  }
}
