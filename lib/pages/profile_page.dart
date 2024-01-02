import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/theme/theme_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UnauthenticatedState) {
          context.go('/login');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Profile'),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            ListTile(
                              leading: Icon(Icons.light_mode),
                              title: const Text('Change theme'),
                              onTap: () {
                                context.read<ThemeCubit>().changeTheme();
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.logout),
                              title: const Text('Logout'),
                              onTap: () {
                                context.read<AuthCubit>().logout();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.settings));
            }),
          ],
        ),
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
              return ListView(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: ClipOval(
                      child: Image.network(
                        
                            user
                            .profileImageUrl,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    user
                        .getFullName(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "@${user.username}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    user
                        .about,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      '0 followers',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      " • ",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      '0 following',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ]),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 150,
                        child: TextButton(
                          onPressed: () {
                            context.go('/profile/edit');
                            //StatefulNavigationShell.of(context).goBranch();;
                          },
                          style: Theme.of(context).textButtonTheme.style,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Edit Profile',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        }),
      ),
    );
  }
}
