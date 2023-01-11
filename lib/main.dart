import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_it/pages/home/cubit/homepage_cubit.dart';
import 'package:post_it/pages/login/cubit/login_cubit.dart';
import 'package:post_it/pages/login/root.dart';
import 'package:post_it/repositories/items_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomepageCubit(ItemsRepository())..start(),
        ),
        BlocProvider(
          create: (context) => LoginCubit()..start(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Post It',
        home: RootPage(),
      ),
    );
  }
}
