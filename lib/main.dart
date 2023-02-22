import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/providers/stepper_provider.dart';
import 'package:test_flutter/services/weather_services.dart';
import 'package:test_flutter/screens/add_screen.dart';
import 'package:test_flutter/screens/home_screen.dart';
import 'package:test_flutter/share_preferences/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherServices(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => StepperProvider(),
          lazy: false,
        ),
      ],
      child: MyApp(),
      )
    );

} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Flutter',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'add' : (_) => const AddScreen(),
      },
    );
  }
}