import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/components/edit_profile_text.dart';
import 'package:social_media/components/error_snack_bar.dart';
import 'package:social_media/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:social_media/edit_profile/cubit/edit_profile_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final aboutController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(
          authCubit: context.read<AuthCubit>(),
          prevUrl: (context.read<AuthCubit>().state as AuthenticatedState)
              .user
              .profileImageUrl),
      child: BlocListener<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccessState) {
            context.go("/profile");
          }
          if (state is EditProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
                content: ErrorSnackBar(errorMessage: state.errorMessage)));
          }
        },
        child: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => context.go('/profile')),
                centerTitle: true,
                title: const Text("Edit Profile"),
                actions: [
                  Builder(builder: (context) {
                    return IconButton(
                      onPressed: () async {
                        await context.read<EditProfileCubit>().updateProfile(
                            firstNameController.text,
                            lastNameController.text,
                            usernameController.text,
                            aboutController.text);
                      },
                      icon: const Icon(Icons.check),
                      color: Theme.of(context).colorScheme.primary,
                    );
                  }),
                ]),
            body: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
              switch (state) {
                case AuthLoadingState():
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case UnauthenticatedState():
                  return const Center(
                    child: Text('Unauthenticated'),
                  );
                case AuthFailureState(errorMessage: final errorMessage):
                  return Center(
                    child: Text(errorMessage),
                  );
                case AuthenticatedState(user: final user):
                  return BlocBuilder<EditProfileCubit, EditProfileState>(
                      builder: (context, state) {
                    switch (state) {
                      case EditProfileLoadingState():
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case EditProfileSuccessState():
                        return const Center(
                          child: CircularProgressIndicator(),
                        );

                      case EditProfileInitialState() || EditProfileErrorState():
                        return ListView(children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              context.read<EditProfileCubit>().imageFile != null
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(context
                                          .read<EditProfileCubit>()
                                          .imageFile!))
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          NetworkImage(user.profileImageUrl)),
                              Positioned(
                                  bottom: -10,
                                  left: 205,
                                  child: IconButton(
                                    onPressed: () async {
                                      showCupertinoModalPopup(
                                        context: context,
                                        builder: (BuildContext innerContext) =>
                                            CupertinoActionSheet(
                                          title: const Text('Choose options'),
                                          actions: <CupertinoActionSheetAction>[
                                            CupertinoActionSheetAction(
                                              child: const Text(
                                                  'Pick from Gallery'),
                                              onPressed: () {
                                                innerContext.pop();
                                                context
                                                    .read<EditProfileCubit>()
                                                    .pickProfileImage(
                                                        ImageSource.gallery);
                                              },
                                            ),
                                            CupertinoActionSheetAction(
                                              child: const Text('Take a Photo'),
                                              onPressed: () {
                                                innerContext.pop();
                                                context
                                                    .read<EditProfileCubit>()
                                                    .pickProfileImage(
                                                        ImageSource.camera);
                                              },
                                            ),
                                          ],
                                          cancelButton:
                                              CupertinoActionSheetAction(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              innerContext.pop();
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.add_circle_outline),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: EditProfileText(
                                title: "First Name",
                                controller: firstNameController
                                  ..text = user.firstName,
                              )),
                              Flexible(
                                child: EditProfileText(
                                  controller: lastNameController
                                    ..text = user.lastName,
                                  title: "Last Name",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          EditProfileText(
                            title: "Username",
                            controller: usernameController
                              ..text = user.username,
                          ),
                          const SizedBox(height: 30),
                          EditProfileText(
                            title: "About",
                            controller: aboutController..text = user.about,
                          ),
                          const SizedBox(height: 50)
                        ]);
                    }

                    if (state is EditProfileInitialState) {}
                    return const Center(
                      child: Text("Error"),
                    );
                  });
              }
              return const Center(
                child: Text("Error"),
              );
            })),
      ),
    );
  }
}
