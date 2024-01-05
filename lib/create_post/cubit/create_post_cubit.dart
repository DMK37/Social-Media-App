import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/create_post/cubit/create_post_state.dart';
import 'package:social_media/data/models/post_model.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/data/repository/post_repository.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  PostRepository postRepository = PostRepository();
  final _storage = FirebaseStorage.instance;
  final AuthCubit authCubit;
  File? imageFile;
  XFile? originalImage;
  final picker = ImagePicker();
  CreatePostCubit({required this.authCubit}) : super(CreatePostInitiaState());

  Future<void> pickPostImage(ImageSource source) async {
    emit(CreatePostLoadingState());
    
    final pickedFile = await picker.pickImage(source: source);
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
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioLockEnabled: true,
          ),
        ],
      );
      if (croppedImage != null) {
        imageFile = File(croppedImage.path);
      }
    }
    emit(CreatePostSuccessState());
  }

  createPost(String description, List<String> tags) async {
    emit(CreatePostLoadingState());

    UserModel? user = (authCubit.state as AuthenticatedState).user;
    PostModel postModel = PostModel(
      userId: user.userId!,
      description: description,
      imageUrl: '',
      tags: tags,
      timestamp: DateTime.now(),
    );
    postModel = await postRepository.createPost(postModel);
    final ref = _storage.ref().child('posts/${postModel.postId}.jpg');
    await ref.putFile(imageFile!);
    final url = await ref.getDownloadURL();
    String id = postModel.postId!;
    postModel = PostModel(
      userId: user.userId!,
      description: postModel.description,
      imageUrl: url,
      tags: postModel.tags,
      timestamp: postModel.timestamp,
    );
    await FirebaseFirestore.instance.collection('your_collection').doc(id).update(postModel.toJson());
    emit(CreatePostSuccessState());
  }
}
