import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/bloc_observer.dart/bloc_oberver.dart';
import 'features/tv/presentation/bloc/show_bloc.dart';
import 'features/tv/presentation/layout/cubit/main_cubit.dart';
import 'features/tv/presentation/layout/main_screen.dart';
import 'injection_container.dart' as injector;
import 'features/movies/presentation/bloc/movie_bloc.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      // Use blocs...
    },
    blocObserver: MyBlocObserver(),
  );
  await injector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => sl<MovieBloc>()),
        BlocProvider(create: (context) => sl<ShowBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent, elevation: 0.0),
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
