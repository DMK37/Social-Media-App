import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/create_post/cubit/create_post_cubit.dart';
import 'package:social_media/data/repository/firebase_auth_repository.dart';
import 'package:social_media/firebase_options.dart';
import 'package:social_media/router_config.dart';
import 'package:social_media/theme/theme_cubit.dart';

void main() async {
  final appRouter = AppRouter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(router: appRouter.router));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});
  final GoRouter router;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthCubit(FirebaseAuthRepository())..isAuthenticated(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(create: (context) => CreatePostCubit(authCubit: context.read<AuthCubit>()))
      ],
      child: Builder(builder: (context) {
        return MaterialApp.router(
          routerConfig: router,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: context.watch<ThemeCubit>().state,
        );
      }),
    );
  }
}
