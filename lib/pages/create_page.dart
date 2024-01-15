import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/components/success_snack_bar.dart';
import 'package:social_media/post/create_post/cubit/create_post_cubit.dart';
import 'package:social_media/post/create_post/cubit/create_post_state.dart';
import 'package:social_media/post/cubit/user_posts_cubit.dart';

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
            context.read<ProfilePostsCubit>().fetchPosts();
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
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 70,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
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
                  const SizedBox(
                    height: 30,
                  ),
                  Wrap(
                    children: context.read<CreatePostCubit>().tags.map(
                      (tag) {
                        bool isSelected = false;
                        if (context
                            .read<CreatePostCubit>()
                            .selectedTags!
                            .contains(tag)) {
                          isSelected = true;
                        }
                        return GestureDetector(
                          onTap: () {
                            if (!context
                                .read<CreatePostCubit>()
                                .selectedTags!
                                .contains(tag)) {
                              context
                                  .read<CreatePostCubit>()
                                  .selectedTags!
                                  .add(tag);
                              setState(() {});
                            } else {
                              context
                                  .read<CreatePostCubit>()
                                  .selectedTags!
                                  .removeWhere((element) => element == tag);
                              setState(() {});
                            }
                          },
                          child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 4),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 12),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                        color: isSelected
                                            ? Theme.of(context)
                                                .colorScheme
                                                .tertiary
                                            : Colors.grey,
                                        width: 2)),
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                      color: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .tertiary
                                          : Colors.grey,
                                      fontSize: 14),
                                ),
                              )),
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        context
                            .read<CreatePostCubit>()
                            .createPost(descriptionController.text);
                      },
                      child: const Text('Create Post')),
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
