import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/components/edit_profile_text.dart';
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
      create: (_) => EditProfileCubit(authCubit: context.read<AuthCubit>()),
      child: BlocListener<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccessState) {
            context.pop();
          }
        },
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: const Text("Detail"),
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
              if (state is AuthLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AuthenticatedState) {
                return ListView(children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Icon(
                    Icons.person,
                    size: 50,
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
                          ..text = (context.read<AuthCubit>().state
                                  as AuthenticatedState)
                              .user
                              .firstName,
                      )),
                      Flexible(
                        child: EditProfileText(
                          controller: lastNameController
                            ..text = (context.read<AuthCubit>().state
                                    as AuthenticatedState)
                                .user
                                .lastName,
                          title: "Last Name",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  EditProfileText(
                    title: "Username",
                    controller: usernameController
                      ..text = (context.read<AuthCubit>().state
                              as AuthenticatedState)
                          .user
                          .username,
                  ),
                  const SizedBox(height: 30),
                  EditProfileText(
                    title: "About",
                    controller: aboutController
                      ..text = (context.read<AuthCubit>().state
                              as AuthenticatedState)
                          .user
                          .about,
                  ),
                  const SizedBox(height: 50)
                ]);
              } else {
                return const Center(
                  child: Text("Error"),
                );
              }
            })),
      ),
    );
  }
}
