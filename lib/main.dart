import 'package:contact_bloc_pattern/ui/cubit/detail_page_cubit.dart';
import 'package:contact_bloc_pattern/ui/cubit/main_page_cubit.dart';
import 'package:contact_bloc_pattern/ui/cubit/registration_page_cubit.dart';
import 'package:contact_bloc_pattern/ui/views/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegistrationPageCubit()),
        BlocProvider(create: (context) => DetailPageCubit()),
        BlocProvider(create: (context) => MainPageCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainPage(),
      ),
    );
  }
}
