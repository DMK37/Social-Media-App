import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/components/success_snack_bar.dart';
import 'package:social_media/create_post/cubit/create_post_cubit.dart';
import 'package:social_media/create_post/cubit/create_post_state.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (innerContext) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              innerContext
                  .read<CreatePostCubit>()
                  .pickPostImage(ImageSource.gallery);
              context.pop();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              innerContext
                  .read<CreatePostCubit>()
                  .pickPostImage(ImageSource.camera);
              context.pop();
            },
          ),
        ],
      ),
    );
  }

  final descriptionController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: BlocListener<CreatePostCubit, CreatePostState>(
        listener: (context, state) {
          if (state is CreatePostSuccessState) {
            //context.go('/post');
            descriptionController.clear();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: SuccessSnackBar(
                message: 'Post Created',
              ),
            ));
          }
        },
        child: BlocBuilder<CreatePostCubit, CreatePostState>(
            builder: (context, state) {
          switch (state) {
            case CreatePostLoadingState():
              return const Center(child: CircularProgressIndicator());
            case CreatePostInitiaState() || CreatePostSuccessState():
              return ListView(
                children: [
                  context.read<CreatePostCubit>().imageFile == null
                      ? GestureDetector(
                          onTap: showOptions,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              //color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.secondary),
                            ),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 70,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'No Image selected',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ],
                            )),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.35,
                                width: double.infinity,
                                child: Image.file(
                                  context.read<CreatePostCubit>().imageFile!,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<CreatePostCubit>()
                                            .pickPostImage(ImageSource.gallery);
                                      },
                                      child: const Text("Pick Image")),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  TextButton(
                                    child: const Text("Cropp Image"),
                                    onPressed: () {
                                      context
                                          .read<CreatePostCubit>()
                                          .croppPostImage();
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        focusNode: _focusNode,
                        maxLines: null,
                        autofocus: false,
                        autocorrect: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                          labelStyle: Theme.of(context).textTheme.displayMedium,
                        ),
                        textInputAction: TextInputAction.done,
                        controller: descriptionController,
                        onEditingComplete: () {
                          _focusNode.unfocus();
                        }),
                  ),
                  TextButton(
                      onPressed: () {
                        List<String> tags = [""];
                        context
                            .read<CreatePostCubit>()
                            .createPost(descriptionController.text, tags);
                      },
                      child: const Text('Create Post')),
                  TextButton(
                      onPressed: () {
                        context.push('/post');
                      },
                      child: const Text('Post'))
                ],
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
