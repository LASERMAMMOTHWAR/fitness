import 'package:fitness/screens/more_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


import 'models/model_theme.dart';
import 'utilities/mytheme_preferences.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/exercise_screen.dart';
import '../screens/update_fitness_user_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: ThemeData.dark(),
            theme: themeNotifier.isDark ? ThemeData(brightness: Brightness.dark) : ThemeData(brightness: Brightness.light),
            initialRoute: '/',
            routes: {
              '/': (context) => const LoginScreen(),
              '/home': (context) => const HomeScreen(),
              '/exercise': (context) => const ExerciseScreen(),
              '/user': (context) => const UpdateFitnessUserScreen(),
              '/more': (context) => const AdditionalScreen(),
            },
          );
        }
      ),
    );
  }
}
